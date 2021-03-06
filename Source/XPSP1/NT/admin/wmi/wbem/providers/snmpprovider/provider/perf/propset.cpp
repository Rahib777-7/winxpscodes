

//***************************************************************************

//

//  MINISERV.CPP

//

//  Module: OLE MS SNMP Property Provider

//

//  Purpose: Implementation for the SnmpSetEventObject class. 

//

// Copyright (c) 1996-2001 Microsoft Corporation, All Rights Reserved
//
//***************************************************************************

#include <windows.h>
#include <snmptempl.h>
#include <snmpmt.h>
#include <typeinfo.h>
#include <process.h>
#include <objbase.h>
#include <stdio.h>
#include <wbemidl.h>
#include <wbemint.h>
#include "classfac.h"
#include "guids.h"
#include <snmpcont.h>
#include <snmpevt.h>
#include <snmpthrd.h>
#include <snmplog.h>
#include <snmpcl.h>
#include <instpath.h>
#include <snmptype.h>
#include <snmpauto.h>
#include <snmpobj.h>
#include <genlex.h>
#include <sql_1.h>
#include <objpath.h>
#include "propprov.h"
#include "propsnmp.h"
#include "propset.h"
#include "snmpset.h"
#include "snmpqset.h"

SnmpSetClassObject :: SnmpSetClassObject () : m_RowStatusSpecified ( FALSE ) , m_RowStatusPresent ( FALSE )
{
}

SnmpSetClassObject :: ~SnmpSetClassObject ()
{
}

ULONG SnmpSetClassObject :: NumberOfWritable ()
{
	ULONG t_NumberOfWritable = 0 ;

	WbemSnmpProperty *property ;
	ResetProperty () ;
	while ( property = NextProperty () )
	{
		if ( ! property->GetTag () )
		{
			BOOL t_Status = ( GetSnmpVersion () == 1 ) && ( property->IsSNMPV1Type () ) ;
			t_Status = t_Status || ( ( GetSnmpVersion () == 2 ) && ( property->IsSNMPV2CType () ) ) ;
			if ( t_Status )
			{
				if ( property->IsVirtualKey () == FALSE )
				{
					if ( property->IsWritable () )
					{
						t_NumberOfWritable ++ ;
					}
				}
			}
		}
	}

	return t_NumberOfWritable ;
}

BOOL SnmpSetClassObject :: Check ( WbemSnmpErrorObject &a_errorObject ) 
{
// Check Class Object, used in a Get Request, for validity

	BOOL status = TRUE ;

	WbemSnmpQualifier *qualifier = FindQualifier ( WBEM_QUALIFIER_ROWSTATUS ) ;
	if ( qualifier )
	{
		SnmpInstanceType *value = qualifier->GetValue () ;
		if ( typeid ( *value ) == typeid ( SnmpIntegerType ) )
		{
			SnmpIntegerType *integerType = ( SnmpIntegerType * ) value ;
			m_RowStatusSpecified = integerType->GetValue () ;
		}
		else
		{
// Problem Here

			status = FALSE ;
			a_errorObject.SetStatus ( WBEM_SNMP_E_TYPE_MISMATCH ) ;
			a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
			a_errorObject.SetMessage ( L"Type mismatch for qualifier: RowStatus" ) ;
		}
	}

	qualifier = FindQualifier ( WBEM_QUALIFIER_AGENTSNMPVERSION ) ;
	if ( qualifier )
	{
		SnmpInstanceType *value = qualifier->GetValue () ;
		if ( typeid ( *value ) == typeid ( SnmpDisplayStringType ) )
		{
			SnmpDisplayStringType *displayStringType = ( SnmpDisplayStringType * ) value ;
			wchar_t *t_snmpVersion = displayStringType->GetValue () ;
			SnmpIntegerType integerType ( t_snmpVersion , NULL ) ;
			if ( integerType.SnmpInstanceType :: IsValid () )
			{
				snmpVersion = integerType.GetValue () ;
			}
			else
			{
// Problem Here

				status = FALSE ;
				a_errorObject.SetStatus ( WBEM_SNMP_E_TYPE_MISMATCH ) ;
				a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
				a_errorObject.SetMessage ( L"Type mismatch for qualifier: AgentSNMPVersion" ) ;
			}
		}
		else
		{
// Problem Here

			status = FALSE ;
			a_errorObject.SetStatus ( WBEM_SNMP_E_TYPE_MISMATCH ) ;
			a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
			a_errorObject.SetMessage ( L"Type mismatch for qualifier: AgentSNMPVersion" ) ;
		}
	}

// Check all Properties for validity

	WbemSnmpProperty *property ;
	ResetProperty () ;
	while ( status && ( property = NextProperty () ) )
	{
		status = CheckProperty ( a_errorObject , property ) ;
	}

	if ( ! m_accessible ) 
	{
		status = FALSE ;
		a_errorObject.SetStatus ( WBEM_SNMP_E_NOWRITABLEPROPERTIES ) ;
		a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
		a_errorObject.SetMessage ( L"Class must contain at least one property which is accessible" ) ;
	}

	if ( m_RowStatusSpecified && ! m_RowStatusPresent )
	{
		status = FALSE ;
		a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_CLASS ) ;
		a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
		a_errorObject.SetMessage ( L"Class must contain at least one property which is of type RowStatus" ) ;
	}

	return status ;
}

BOOL SnmpSetClassObject :: CheckProperty ( WbemSnmpErrorObject &a_errorObject , WbemSnmpProperty *property )
{
// Check property validity

	BOOL status = TRUE ;

	if ( typeid ( *property->GetValue () ) == typeid ( SnmpObjectIdentifierType ) )
	{
		SnmpObjectIdentifierType *t_ObjectIdentifier = ( SnmpObjectIdentifierType * ) property->GetValue () ;
		if ( t_ObjectIdentifier->GetValueLength () < 2 ) 
		{
			status = FALSE ;
			a_errorObject.SetStatus ( WBEM_SNMP_E_TYPE_MISMATCH ) ;
			a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;

			wchar_t *temp = UnicodeStringDuplicate ( L"Type Mismatch for property: " ) ;
			wchar_t *stringBuffer = UnicodeStringAppend ( temp , property->GetName () ) ;
			delete [] temp ;
			a_errorObject.SetMessage ( stringBuffer ) ;
			delete [] stringBuffer ; 
		}
	}

	if ( typeid ( *property->GetValue () ) == typeid ( SnmpRowStatusType ) )
	{
		if ( m_RowStatusPresent )
		{
			status = FALSE ;
			a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_CLASS ) ;
			a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
			a_errorObject.SetMessage ( L"Class contains more than one property with RowStatus type definition" ) ;

		}
		else
		{
			m_RowStatusPresent = TRUE ;
		}
	}

	if ( ( snmpVersion == 1 ) && property->IsSNMPV1Type () && property->IsWritable () )
	{
		m_accessible = TRUE ;
	}
	else if ( ( snmpVersion == 2 ) && property->IsSNMPV2CType () && property->IsWritable  () )
	{
		m_accessible = TRUE ;
	}

	return status ;
}

SnmpSetResponseEventObject :: SnmpSetResponseEventObject ( 

	CImpPropProv *providerArg , 
	IWbemClassObject *classObjectArg ,
	IWbemContext *a_Context ,
	long lflags

) : SnmpResponseEventObject ( providerArg , a_Context ) , 
	classObject ( classObjectArg ) , 
	session ( NULL ) , 
	operation ( NULL ) , 
	processComplete ( FALSE ) , 
	m_lflags ( lflags ) ,
	state ( 0 ) ,
	m_SnmpTooBig ( FALSE ) ,
	m_VarBindsLeftBeforeTooBig ( 0 ) 
{
	if ( classObject )
		classObject->AddRef () ;
}

SnmpSetResponseEventObject :: ~SnmpSetResponseEventObject ()
{
	if ( classObject ) 
		classObject->Release () ;
}

BOOL SnmpSetResponseEventObject :: SendSnmp ( WbemSnmpErrorObject &a_errorObject , const ULONG &a_NumberToSend )
{
	m_SnmpTooBig = FALSE ;

	BOOL status = TRUE ;

	wchar_t *agentVersion = NULL ;
	wchar_t *agentAddress = NULL ;
	wchar_t *agentTransport = NULL ;
	wchar_t *agentWriteCommunityName = NULL ;
	ULONG agentRetryCount ;
	ULONG agentRetryTimeout ;
	ULONG agentMaxVarBindsPerPdu ;
	ULONG agentFlowControlWindowSize ;

	status = GetAgentVersion ( m_errorObject , agentVersion ) ;
	if ( status ) status = GetAgentAddress ( m_errorObject , agentAddress ) ;
	if ( status ) status = GetAgentTransport ( m_errorObject , agentTransport ) ;
	if ( status ) status = GetAgentWriteCommunityName ( m_errorObject , agentWriteCommunityName ) ;
	if ( status ) status = GetAgentRetryCount ( m_errorObject , agentRetryCount ) ;
	if ( status ) status = GetAgentRetryTimeout ( m_errorObject , agentRetryTimeout ) ;
	if ( status ) status = GetAgentMaxVarBindsPerPdu ( m_errorObject , agentMaxVarBindsPerPdu ) ;
	if ( status ) status = GetAgentFlowControlWindowSize ( m_errorObject , agentFlowControlWindowSize ) ;

	if ( status )
	{
		char *dbcsAgentAddress = UnicodeToDbcsString ( agentAddress ) ;
		if ( dbcsAgentAddress )
		{
			char *dbcsagentWriteCommunityName = UnicodeToDbcsString ( agentWriteCommunityName ) ;
			if ( dbcsagentWriteCommunityName )
			{
				if ( _wcsicmp ( agentTransport , WBEM_AGENTIPTRANSPORT ) == 0 )
				{
					char *t_Address ;
					if ( provider->GetIpAddressString () && provider->GetIpAddressValue () && _stricmp ( provider->GetIpAddressString () , dbcsAgentAddress ) == 0 )
					{
						t_Address = provider->GetIpAddressValue () ;
					}
					else
					{
						if ( SnmpTransportIpAddress :: ValidateAddress ( dbcsAgentAddress , SNMP_ADDRESS_RESOLVE_VALUE ) )
						{
							t_Address = dbcsAgentAddress ;
						}
						else
						{
							if ( SnmpTransportIpAddress :: ValidateAddress ( dbcsAgentAddress , SNMP_ADDRESS_RESOLVE_NAME ) )
							{
								t_Address = dbcsAgentAddress ;
							}
							else							
							{
								status = FALSE ;
								a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
								a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
								a_errorObject.SetMessage ( L"Illegal IP address value or unresolvable name for AgentAddress" ) ;
							}
						}
					}

					if ( status )
					{
						if ( _wcsicmp ( agentVersion , WBEM_AGENTSNMPVERSION_V1 ) == 0 )
						{
							session = new SnmpV1OverIp (

								t_Address ,
								SNMP_ADDRESS_RESOLVE_NAME | SNMP_ADDRESS_RESOLVE_VALUE ,
								dbcsagentWriteCommunityName ,
								agentRetryCount , 
								agentRetryTimeout ,
								agentMaxVarBindsPerPdu ,
								agentFlowControlWindowSize 
							);

							if ( ! (*session)() )
							{
	DebugMacro3( 

		SnmpDebugLog :: s_SnmpDebugLog->Write (  

			__FILE__,__LINE__,
			L"SNMPCL Session could not be created"
		) ;
	)

								delete session ;
								session = NULL ;

								status = FALSE ;
								a_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR  ) ;
								a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
								a_errorObject.SetMessage ( L"Failed to get transport resources" ) ;
							}
						}
						else if ( _wcsicmp ( agentVersion , WBEM_AGENTSNMPVERSION_V2C ) == 0 )
						{
							session = new SnmpV2COverIp (

								t_Address ,
								SNMP_ADDRESS_RESOLVE_NAME | SNMP_ADDRESS_RESOLVE_VALUE ,
								dbcsagentWriteCommunityName ,
								agentRetryCount , 
								agentRetryTimeout ,
								agentMaxVarBindsPerPdu ,
								agentFlowControlWindowSize 
							);

							if ( ! (*session)() )
							{
	DebugMacro3( 

		SnmpDebugLog :: s_SnmpDebugLog->Write (  

			__FILE__,__LINE__,
			L"SNMPCL Session could not be created"
		) ;
	)

								delete session ;
								session = NULL ;

								status = FALSE ;
								a_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR  ) ;
								a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
								a_errorObject.SetMessage ( L"Failed to get transport resources" ) ;
							}
						}
						else
						{
							status = FALSE ;
							a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
							a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
							a_errorObject.SetMessage ( L"Illegal value for qualifier: AgentSnmpVersion" ) ;

						}
					}
				}
				else if ( _wcsicmp ( agentTransport , WBEM_AGENTIPXTRANSPORT ) == 0 )
				{
					if ( _wcsicmp ( agentVersion , WBEM_AGENTSNMPVERSION_V1 ) == 0 )
					{
						session = new SnmpV1OverIpx (

							dbcsAgentAddress ,
							dbcsagentWriteCommunityName ,
							agentRetryCount , 
							agentRetryTimeout ,
							agentMaxVarBindsPerPdu ,
							agentFlowControlWindowSize 
						);

						if ( ! (*session)() )
						{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SNMPCL Session could not be created"
	) ;
)

							delete session ;
							session = NULL ;

							status = FALSE ;
							a_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR  ) ;
							a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
							a_errorObject.SetMessage ( L"Failed to get transport resources" ) ;
						}
					}
					else if ( _wcsicmp ( agentVersion , WBEM_AGENTSNMPVERSION_V2C ) == 0 )
					{
						session = new SnmpV2COverIpx (

							dbcsAgentAddress  ,
							dbcsagentWriteCommunityName ,
							agentRetryCount , 
							agentRetryTimeout ,
							agentMaxVarBindsPerPdu ,
							agentFlowControlWindowSize 
						);

						if ( ! (*session)() )
						{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SNMPCL Session could not be created"
	) ;
)

							delete session ;
							session = NULL ;

							status = FALSE ;
							a_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR  ) ;
							a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
							a_errorObject.SetMessage ( L"Failed to get transport resources" ) ;
						}
					}
					else
					{
						status = FALSE ;
						a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
						a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
						a_errorObject.SetMessage ( L"Illegal value for qualifier: AgentSnmpVersion" ) ;

					}
				}
				else
				{
					status = FALSE ;
					a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
					a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
					a_errorObject.SetMessage ( L"Illegal value for qualifier: AgentTransport" ) ;
				}

				delete [] dbcsagentWriteCommunityName ;
			}
			else
			{
				status = FALSE ;
				a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
				a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
				a_errorObject.SetMessage ( L"Illegal value for qualifier: agentWriteCommunityName" ) ;
			}

			delete [] dbcsAgentAddress ;

			if ( status )
			{
				operation = new SetOperation(*session,this);
				operation->Send ( a_NumberToSend ) ;
			}
		}
		else
		{
			status = FALSE ;
			a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
			a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
			a_errorObject.SetMessage ( L"Illegal value for qualifier: AgentAddress" ) ;
		}
	}
	else
	{
DebugMacro1( 

SnmpDebugLog :: s_SnmpDebugLog->Write (  

	__FILE__,__LINE__,
	L" TransportInformation settings invalid"
) ;
)
	}

	delete [] agentTransport ;
	delete [] agentAddress ;
	delete [] agentVersion ;
	delete [] agentWriteCommunityName ;

	return status ;
}

SnmpUpdateEventObject :: SnmpUpdateEventObject (

	CImpPropProv *providerArg , 
	IWbemClassObject *classObject ,
	IWbemContext *a_Context ,
	long lflags 

) : SnmpSetResponseEventObject ( providerArg , classObject , a_Context , lflags ) 
{
}

SnmpUpdateEventObject :: ~SnmpUpdateEventObject ()
{
}

BOOL SnmpUpdateEventObject :: CheckForRowExistence ( WbemSnmpErrorObject &a_errorObject )
{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SnmpUpdateEventObject :: CheckForRowExistence ( WbemSnmpErrorObject &a_errorObject )" 
	) ;
)


	BOOL t_Status = FALSE ;

	BOOL status = TRUE ;

	wchar_t *agentVersion = NULL ;
	wchar_t *agentAddress = NULL ;
	wchar_t *agentTransport = NULL ;
	wchar_t *agentWriteCommunityName = NULL ;
	ULONG agentRetryCount ;
	ULONG agentRetryTimeout ;
	ULONG agentMaxVarBindsPerPdu ;
	ULONG agentFlowControlWindowSize ;

	status = GetAgentVersion ( m_errorObject , agentVersion ) ;
	if ( status ) status = GetAgentAddress ( m_errorObject , agentAddress ) ;
	if ( status ) status = GetAgentTransport ( m_errorObject , agentTransport ) ;
	if ( status ) status = GetAgentWriteCommunityName ( m_errorObject , agentWriteCommunityName ) ;
	if ( status ) status = GetAgentRetryCount ( m_errorObject , agentRetryCount ) ;
	if ( status ) status = GetAgentRetryTimeout ( m_errorObject , agentRetryTimeout ) ;
	if ( status ) status = GetAgentMaxVarBindsPerPdu ( m_errorObject , agentMaxVarBindsPerPdu ) ;
	if ( status ) status = GetAgentFlowControlWindowSize ( m_errorObject , agentFlowControlWindowSize ) ;

	if ( status )
	{
		char *dbcsAgentAddress = UnicodeToDbcsString ( agentAddress ) ;
		if ( dbcsAgentAddress )
		{
			char *dbcsagentWriteCommunityName = UnicodeToDbcsString ( agentWriteCommunityName ) ;
			if ( dbcsagentWriteCommunityName )
			{
				if ( _wcsicmp ( agentTransport , WBEM_AGENTIPTRANSPORT ) == 0 )
				{
					char *t_Address ;
					if ( provider->GetIpAddressString () && provider->GetIpAddressValue () && _stricmp ( provider->GetIpAddressString () , dbcsAgentAddress ) == 0 )
					{
						t_Address = provider->GetIpAddressValue () ;
					}
					else
					{
						if ( SnmpTransportIpAddress :: ValidateAddress ( dbcsAgentAddress , SNMP_ADDRESS_RESOLVE_VALUE ) )
						{
							t_Address = dbcsAgentAddress ;
						}
						else
						{
							if ( SnmpTransportIpAddress :: ValidateAddress ( dbcsAgentAddress , SNMP_ADDRESS_RESOLVE_NAME ) )
							{
								t_Address = dbcsAgentAddress ;
							}
							else							
							{
								status = FALSE ;
								a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
								a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
								a_errorObject.SetMessage ( L"Illegal IP address value or unresolvable name for AgentAddress" ) ;
							}
						}
					}

					if ( status )
					{
						if ( _wcsicmp ( agentVersion , WBEM_AGENTSNMPVERSION_V1 ) == 0 )
						{
							session = new SnmpV1OverIp (

								t_Address ,
								SNMP_ADDRESS_RESOLVE_NAME | SNMP_ADDRESS_RESOLVE_VALUE ,
								dbcsagentWriteCommunityName ,
								agentRetryCount , 
								agentRetryTimeout ,
								agentFlowControlWindowSize ,
								agentMaxVarBindsPerPdu 
							);

							if ( ! (*session)() )
							{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SNMPCL Session could not be created"
	) ;
)

								delete session ;
								session = NULL ;

								status = FALSE ;
								a_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR  ) ;
								a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
								a_errorObject.SetMessage ( L"Failed to get transport resources" ) ;
							}
						}
						else if ( _wcsicmp ( agentVersion , WBEM_AGENTSNMPVERSION_V2C ) == 0 )
						{
							session = new SnmpV2COverIp (

								t_Address ,
								SNMP_ADDRESS_RESOLVE_NAME | SNMP_ADDRESS_RESOLVE_VALUE ,
								dbcsagentWriteCommunityName ,
								agentRetryCount , 
								agentRetryTimeout ,
								agentFlowControlWindowSize ,
								agentMaxVarBindsPerPdu 
							);

							if ( ! (*session)() )
							{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SNMPCL Session could not be created"
	) ;
)

								delete session ;
								session = NULL ;

								status = FALSE ;
								a_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR  ) ;
								a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
								a_errorObject.SetMessage ( L"Failed to get transport resources" ) ;
							}
						}
						else
						{
							status = FALSE ;
							a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
							a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
							a_errorObject.SetMessage ( L"Illegal value for qualifier: AgentSnmpVersion" ) ;

						}
					}
				}
				else if ( _wcsicmp ( agentTransport , WBEM_AGENTIPXTRANSPORT ) == 0 )
				{
					if ( _wcsicmp ( agentVersion , WBEM_AGENTSNMPVERSION_V1 ) == 0 )
					{
						session = new SnmpV1OverIpx (

							dbcsAgentAddress ,
							dbcsagentWriteCommunityName ,
							agentRetryCount , 
							agentRetryTimeout ,
							agentFlowControlWindowSize ,
							agentMaxVarBindsPerPdu 
						);

						if ( ! (*session)() )
						{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SNMPCL Session could not be created"
	) ;
)

							delete session ;
							session = NULL ;

							status = FALSE ;
							a_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR  ) ;
							a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
							a_errorObject.SetMessage ( L"Failed to get transport resources" ) ;
						}
					}
					else if ( _wcsicmp ( agentVersion , WBEM_AGENTSNMPVERSION_V2C ) == 0 )
					{
						session = new SnmpV2COverIpx (

							dbcsAgentAddress  ,
							dbcsagentWriteCommunityName ,
							agentRetryCount , 
							agentRetryTimeout ,
							agentFlowControlWindowSize ,
							agentMaxVarBindsPerPdu 
						);

						if ( ! (*session)() )
						{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SNMPCL Session could not be created"
	) ;
)

							delete session ;
							session = NULL ;

							status = FALSE ;
							a_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR  ) ;
							a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
							a_errorObject.SetMessage ( L"Failed to get transport resources" ) ;
						}
					}
					else
					{
						status = FALSE ;
						a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
						a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
						a_errorObject.SetMessage ( L"Illegal value for qualifier: AgentSnmpVersion" ) ;

					}
				}
				else
				{
					status = FALSE ;
					a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
					a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
					a_errorObject.SetMessage ( L"Illegal value for qualifier: AgentTransport" ) ;
				}

				delete [] dbcsagentWriteCommunityName ;
			}
			else
			{
				status = FALSE ;
				a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
				a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
				a_errorObject.SetMessage ( L"Illegal value for qualifier: agentWriteCommunityName" ) ;
			}

			delete [] dbcsAgentAddress ;

			if ( status )
			{
				m_QueryOperation = new SetQueryOperation(*session,this);
				operation->Send () ;
			}
		}
		else
		{
			status = FALSE ;
			a_errorObject.SetStatus ( WBEM_SNMP_E_INVALID_TRANSPORTCONTEXT ) ;
			a_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
			a_errorObject.SetMessage ( L"Illegal value for qualifier: AgentAddress" ) ;
		}
	}
	else
	{
DebugMacro1( 

SnmpDebugLog :: s_SnmpDebugLog->Write (  

	__FILE__,__LINE__,
	L" TransportInformation settings invalid"
) ;
)
	}

	delete [] agentTransport ;
	delete [] agentAddress ;
	delete [] agentVersion ;
	delete [] agentWriteCommunityName ;

	return status ;
}

BOOL SnmpUpdateEventObject :: Update ( WbemSnmpErrorObject &a_errorObject )
{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SnmpUpdateEventObject :: Update ( WbemSnmpErrorObject &a_errorObject )" 
	) ;
)

	BOOL status = TRUE ;
	HRESULT t_WBEM_result = WBEM_S_NO_ERROR ;

	IWbemClassObject *t_ClassObject = NULL ;
	IWbemCallResult *errorObject = NULL ;

	VARIANT variant ;
	VariantInit ( & variant ) ;

	t_WBEM_result = classObject->Get ( WBEM_PROPERTY_CLASS , 0 , &variant , NULL , NULL ) ;
	if ( SUCCEEDED ( t_WBEM_result ) )
	{
		HRESULT result = provider->GetServer()->GetObject (

			variant.bstrVal ,
			0 ,
			m_Context ,
			& t_ClassObject ,
			& errorObject 
		) ;

		if ( errorObject )
			errorObject->Release () ;

		VariantClear ( & variant ) ;

		if ( SUCCEEDED ( result ) )
		{
			if ( status = GetNamespaceObject ( a_errorObject ) )
			{
				status = snmpObject.Set ( a_errorObject , t_ClassObject , FALSE ) ;
				if ( status )
				{
					status = snmpObject.Merge ( a_errorObject , GetClassObject () ) ;
					if ( status )
					{
						status = snmpObject.Check ( a_errorObject ) ;
						if ( status )
						{
							status = HandleSnmpVersion ( a_errorObject ) ;
						}
						else
						{
DebugMacro3( 

SnmpDebugLog :: s_SnmpDebugLog->Write (  

	__FILE__,__LINE__,
	L"Failed During Check : Class definition did not conform to mapping"
) ;
)

						}
					}
					else
					{
DebugMacro3( 

SnmpDebugLog :: s_SnmpDebugLog->Write (  

	__FILE__,__LINE__,
	L"Failed During Merge : Class definition did not conform to mapping"
) ;
)
					}
				}
				else
				{
DebugMacro3( 

SnmpDebugLog :: s_SnmpDebugLog->Write (  

	__FILE__,__LINE__,
	L"Failed During Set : Class definition did not conform to mapping"
) ;
)
				}
			}

			t_ClassObject->Release () ;
		}
	}

DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Returning from SnmpUpdateEventObject :: Update ( WbemSnmpErrorObject &a_errorObject ) with Result (%lx)" ,
		a_errorObject.GetWbemStatus () 
	) ;
)
	return status ;
}

SnmpUpdateAsyncEventObject :: SnmpUpdateAsyncEventObject (

	CImpPropProv *providerArg , 
	IWbemClassObject *classObject ,
	IWbemObjectSink *notify ,
	IWbemContext *a_Context ,
	long lflags 

) : SnmpUpdateEventObject ( providerArg , classObject , a_Context , lflags ) , notificationHandler ( notify ) 
{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SnmpUpdateAsyncEventObject :: SnmpUpdateAsyncEventObject ()" 
	) ;
)

	notify->AddRef () ;
}

SnmpUpdateAsyncEventObject :: ~SnmpUpdateAsyncEventObject () 
{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SnmpUpdateAsyncEventObject :: ~SnmpUpdateAsyncEventObject ()" 
	) ;
)

	// Get Status object

	if ( FAILED ( m_errorObject.GetWbemStatus () ) )
	{
		IWbemClassObject *notifyStatus ;
		BOOL status = GetSnmpNotifyStatusObject ( &notifyStatus ) ;
		if ( status )
		{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Sending Status" 
	) ;
)

			HRESULT result = notificationHandler->SetStatus ( 0 , m_errorObject.GetWbemStatus () , NULL , notifyStatus ) ;
			notifyStatus->Release () ;
		}
		else
		{
			HRESULT result = notificationHandler->SetStatus ( 0 , m_errorObject.GetWbemStatus () , NULL , NULL ) ;
		}
	}
	else
	{
		HRESULT result = notificationHandler->SetStatus ( 0 , m_errorObject.GetWbemStatus () , NULL , NULL ) ;
	}

	notificationHandler->Release () ;

DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Returning from SnmpUpdateAsyncEventObject :: ~SnmpUpdateAsyncEventObject ()" 
	) ;
)

}

void SnmpUpdateAsyncEventObject :: SetComplete () 
{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SnmpUpdateAsyncEventObject :: SetComplete ()" 
	) ;
)

	if ( SUCCEEDED ( m_errorObject.GetWbemStatus () ) )
	{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Update Succeeded" 
	) ;
)

		WbemSnmpErrorObject errorObject ;
		IWbemClassObject *classObject = GetClassObject () ;
		BOOL status = snmpObject.Get ( errorObject , classObject ) ;
		if ( status )
		{
			if ( notificationHandler )
			{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Sending Object" 
	) ;
)

				notificationHandler->Indicate ( 1 , & classObject ) ;
			}
		}
		else
		{
		}
	}
	else
	{
	}

/*
 *	Remove worker object from worker thread container
 */

DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Reaping Task" 
	) ;
)

	CImpPropProv :: s_defaultPutThreadObject->ReapTask ( *this ) ;

	SetOperation *t_operation = operation ;

DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Deleting (this)" 
	) ;
)

	delete this ;

DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Destroying SNMPCL operation" 
	) ;
)

	if ( t_operation )
		t_operation->DestroyOperation () ;

DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Returning from SnmpUpdateAsyncEventObject :: SetComplete ()" 
	) ;
)

}

void SnmpUpdateAsyncEventObject :: Process () 
{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SnmpUpdateAsyncEventObject :: Process ()" 
	) ;
)

	switch ( state )
	{
		case 0:
		{
			Complete () ;
			WaitAcknowledgement () ;
			BOOL status = Update ( m_errorObject ) ;
			if ( status )
			{
			}
			else
			{
				ReceiveComplete () ;
			}
		}
		break ;

		default:
		{
		}
		break ;
	}

DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Returning from SnmpUpdateAsyncEventObject :: Process ()" 
	) ;
)

}

BOOL SnmpUpdateEventObject :: HandleSnmpVersion ( WbemSnmpErrorObject &a_ErrorObject )
{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SnmpUpdateEventObject :: HandleSnmpVersion ( WbemSnmpErrorObject &a_ErrorObject )" 
	) ;
)

	BOOL t_Status = FALSE ;

	if ( snmpObject.RowStatusSpecified () )
	{
		if ( snmpObject.GetSnmpVersion () == 1 )
		{
			if ( m_lflags == WBEM_FLAG_CREATE_OR_UPDATE )
			{
				t_Status = Create_Or_Update () ;
			}
			else if ( m_lflags == WBEM_FLAG_CREATE_ONLY )
			{
				t_Status = Create_Only () ;
			}
			else if ( m_lflags == WBEM_FLAG_UPDATE_ONLY )
			{
				t_Status = Update_Only () ;
			}
			else
			{
				t_Status = FALSE ;
			}
		}
		else
		{
			if ( m_lflags == WBEM_FLAG_CREATE_OR_UPDATE )
			{
				t_Status = Create_Or_Update () ;
			}
			else if ( m_lflags == WBEM_FLAG_CREATE_ONLY )
			{
				t_Status = Create_Only () ;
			}
			else if ( m_lflags == WBEM_FLAG_UPDATE_ONLY )
			{
				t_Status = Update_Only () ;
			}
			else
			{
				t_Status = FALSE ;
			}
		}	
	}
	else
	{
		if ( m_lflags == WBEM_FLAG_CREATE_OR_UPDATE )
		{
			state = 0 ;
			t_Status = SendSnmp ( a_ErrorObject ) ;
		}
		else if ( m_lflags == WBEM_FLAG_CREATE_ONLY )
		{
			state = 1 ;
			t_Status = CheckForRowExistence ( a_ErrorObject ) ;
		}
		else if ( m_lflags == WBEM_FLAG_UPDATE_ONLY )
		{
			state = 2 ;
			t_Status = CheckForRowExistence ( a_ErrorObject ) ;
		}
		else
		{
			t_Status = FALSE ;
		}
	}

	return t_Status ;
}

void SnmpUpdateAsyncEventObject :: ReceiveComplete () 
{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SnmpUpdateAsyncEventObject :: ReceiveComplete ()" 
	) ;
)

	BOOL t_Status = TRUE ;

	switch ( state )
	{
		case 0:
		{
/*
 *	V1 SMI - CREATE_OR_UPDATE
 */

			if ( m_SnmpTooBig )
			{
				m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
				m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
				m_errorObject.SetMessage ( L"Agent could not process Set Request because SNMP PDU was too big" ) ;
			}

			SetComplete () ;
			return ;
		}
		break ;

		case 1:
		{
/*
*	V1 SMI - CREATE_ONLY
*/

			if ( ! SUCCEEDED ( m_errorObject.GetStatus () ) )
			{
				SetComplete () ;
				return ;
			}

			state = 3 ;
			if ( m_QueryOperation->GetRowReceived () == 0 )
			{
				t_Status = SendSnmp ( m_errorObject ) ;
			}
			else
			{
				m_errorObject.SetStatus ( WBEM_SNMP_E_ALREADY_EXISTS  ) ;
				m_errorObject.SetWbemStatus ( WBEM_E_ALREADY_EXISTS ) ;
				m_errorObject.SetMessage ( L"Instance already exists" ) ;

				t_Status = FALSE ;
			}

			if ( m_QueryOperation )
				m_QueryOperation->DestroyOperation () ;

		}
		break ;

		case 2:
		{
/*
*	V1 SMI - UPDATE_ONLY
*/
			if ( ! SUCCEEDED ( m_errorObject.GetStatus () ) )
			{
				SetComplete () ;
				return ;
			}

			state = 3 ;
			if ( m_QueryOperation->GetRowReceived () )
			{
				t_Status = SendSnmp ( m_errorObject ) ;
			}
			else
			{
				m_errorObject.SetStatus ( WBEM_SNMP_E_NOT_FOUND ) ;
				m_errorObject.SetWbemStatus ( WBEM_E_NOT_FOUND ) ;
				m_errorObject.SetMessage ( L"Instance does not exist" ) ;

				t_Status = FALSE ;
			}

			if ( m_QueryOperation )
				m_QueryOperation->DestroyOperation () ;

		}
		break ;

		case 3:
		{
			if ( m_SnmpTooBig )
			{
				m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
				m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
				m_errorObject.SetMessage ( L"Agent could not process Set Request because SNMP PDU was too big" ) ;
			}
			
			t_Status = FALSE ;
		}
		break ;

		case 4:
		{
/*
*	V2C SMI ROWSTATUS - CREATE_OR_UPDATE
*/

			m_errorObject.SetStatus ( WBEM_SNMP_E_PROVIDER_FAILURE  ) ;
			m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
			m_errorObject.SetMessage ( L"UNKNOWN STATE TRANSITION" ) ;

			t_Status = FALSE ;

		}
		break ;

		case 10:
		{
/*
 *	V2C SMI ROWSTATUS - CREATE_ONLY
 */

			WbemSnmpProperty *t_Property ;
			snmpObject.ResetProperty () ;
			while ( t_Property = snmpObject.NextProperty () )
			{
				t_Property->SetTag ( FALSE ) ;
			}

			ULONG t_VarBindsPerPdu = 0 ;

			t_Status = GetAgentMaxVarBindsPerPdu ( m_errorObject , t_VarBindsPerPdu ) ;
			if ( t_Status ) 
			{
				m_VarBindsLeftBeforeTooBig = t_VarBindsPerPdu ;

				ULONG t_NumberOfWritable = snmpObject.NumberOfWritable () ;

/*
 * Check to see if we can fit all vbs in to one pdu
 */
				if ( t_NumberOfWritable < t_VarBindsPerPdu )
				{

// Does fit
					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						t_NumberOfWritable , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: createAndGo 
					) ;

					state = 11 ;
				}
				else
				{
// Does not fit, therefore decompose

					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						m_VarBindsLeftBeforeTooBig , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: createAndWait 
					) ;

					state = 12 ;
				}
			}
			else
			{
				m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
				m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
				m_errorObject.SetMessage ( L"Internal Error" ) ;
				t_Status = FALSE ;
			}
		}
		break ;

		case 11:
		{
/*
 * check to see if we fitted everything into one pdu
 */
			if ( m_SnmpTooBig )
			{
/*
 * PDU TOO BIG
 */

/*
 * Decrement the number of variable bindings so that we can avoid an SNMP TOO BIG response
 */

				m_VarBindsLeftBeforeTooBig -- ;

/*
 * Resend
 */
				t_Status = Send_Variable_Binding_List ( 

					snmpObject , 
					m_VarBindsLeftBeforeTooBig , 
					SnmpRowStatusType :: SnmpRowStatusEnum :: createAndWait 
				) ;

				state = 12 ;
			}
			else
			{
/*
 *	We've either succeeded or totally failed.
 */
				if ( t_Status = SUCCEEDED ( m_errorObject.GetWbemStatus () ) )
				{
				}
				else
				{
				}
			}
		}
		break ;

		case 12:
		{
/*
 * check to see if we fitted everything into one pdu
 */
			if ( m_SnmpTooBig )
			{
/*
 * PDU TOO BIG
 */
				if ( m_VarBindsLeftBeforeTooBig == 0 )
				{
/*
 *	Set Error object for TooBig because we only sent one vb
 */
					
					t_Status = FALSE ;
				}
				else
				{
/*
 * Decrement the number of variable bindings so that we can avoid an SNMP TOO BIG response
 */

					m_VarBindsLeftBeforeTooBig -- ;

/*
 * Resend
 */
					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						m_VarBindsLeftBeforeTooBig , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: createAndWait 
					) ;

					state = 12 ;
				}
			}
			else
			{
/*
 *	We've either succeeded or totally failed to set the row as createAndWait
 */

				if ( t_Status = SUCCEEDED ( m_errorObject.GetWbemStatus () ) )
				{
/*
 *	Now send a non row status variable binding list
 */
					ULONG t_VarBindsPerPdu = 0 ;

					t_Status = GetAgentMaxVarBindsPerPdu ( m_errorObject , t_VarBindsPerPdu ) ;
					if ( t_Status ) 
					{
						m_VarBindsLeftBeforeTooBig = t_VarBindsPerPdu ;

						t_Status = Send_Variable_Binding_List ( 

							snmpObject , 
							m_VarBindsLeftBeforeTooBig
						) ;

						state = 13 ;
					}
					else
					{
						m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
						m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
						m_errorObject.SetMessage ( L"Internal Error" ) ;
						t_Status = FALSE ;
					}
				}
				else
				{
				}
			}
		}
		break ;

		case 13:
		{
/*
 * check to see if we succeeded in sending a non row status variable binding list
 */

			if ( m_SnmpTooBig )
			{
				if ( m_VarBindsLeftBeforeTooBig == 0 )
				{
/*
 *	Set Error object for TooBig because we only sent one vb
 */
					
					t_Status = FALSE ;
				}
				else
				{
					m_VarBindsLeftBeforeTooBig -- ;

					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						m_VarBindsLeftBeforeTooBig , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: createAndWait 
					) ;

					state = 13 ;
				}
			}
			else
			{
				if ( snmpObject.NumberOfWritable () == 0 )
				{
					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						0 , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: active 
					) ;

					state = 14 ;
				}
				else
				{
					ULONG t_VarBindsPerPdu = 0 ;

					t_Status = GetAgentMaxVarBindsPerPdu ( m_errorObject , t_VarBindsPerPdu ) ;
					if ( t_Status ) 
					{
						m_VarBindsLeftBeforeTooBig = t_VarBindsPerPdu ;

						t_Status = Send_Variable_Binding_List ( 

							snmpObject , 
							m_VarBindsLeftBeforeTooBig 
						) ;

						state = 13 ;
					}
					else
					{
						m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
						m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
						m_errorObject.SetMessage ( L"Internal Error" ) ;
						t_Status = FALSE ;
					}
				}
			}
		}
		break ;

		case 14:
		{
			if ( m_SnmpTooBig )
			{
				m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
				m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
				m_errorObject.SetMessage ( L"Agent could not process Set Request because SNMP PDU was too big" ) ;

				t_Status = FALSE ;
			}
			else
			{
				SetComplete () ;
				return ;
			}
		}
		break ;

		case 20:
		{
/*
 *	V2C SMI ROWSTATUS - UPDATE_ONLY
 */

			WbemSnmpProperty *t_Property ;
			snmpObject.ResetProperty () ;
			while ( t_Property = snmpObject.NextProperty () )
			{
				t_Property->SetTag ( FALSE ) ;
			}

			ULONG t_VarBindsPerPdu = 0 ;

			t_Status = GetAgentMaxVarBindsPerPdu ( m_errorObject , t_VarBindsPerPdu ) ;
			if ( t_Status ) 
			{
				m_VarBindsLeftBeforeTooBig = t_VarBindsPerPdu ;

				ULONG t_NumberOfWritable = snmpObject.NumberOfWritable () ;

/*
 * Check to see if we can fit all vbs in to one pdu
 */
				if ( t_NumberOfWritable < t_VarBindsPerPdu )
				{

// Does fit
					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						t_NumberOfWritable , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: active 
					) ;

					state = 21 ;
				}
				else
				{
// Does not fit, therefore decompose

					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						m_VarBindsLeftBeforeTooBig , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: notInService 
					) ;

					state = 22 ;
				}
			}
			else
			{
				m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
				m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
				m_errorObject.SetMessage ( L"Internal Error" ) ;
				t_Status = FALSE ;
			}
		}
		break ;

		case 21:
		{
/*
 * check to see if we fitted everything into one pdu
 */
			if ( m_SnmpTooBig )
			{
/*
 * PDU TOO BIG
 */

/*
 * Decrement the number of variable bindings so that we can avoid an SNMP TOO BIG response
 */

				m_VarBindsLeftBeforeTooBig -- ;

/*
 * Resend
 */
				t_Status = Send_Variable_Binding_List ( 

					snmpObject , 
					m_VarBindsLeftBeforeTooBig , 
					SnmpRowStatusType :: SnmpRowStatusEnum :: notInService 
				) ;

				state = 22 ;
			}
			else
			{
/*
 *	We've either succeeded or totally failed.
 */
				if ( t_Status = SUCCEEDED ( m_errorObject.GetWbemStatus () ) )
				{
				}
				else
				{
				}
			}
		}
		break ;

		case 22:
		{
/*
 * check to see if we fitted everything into one pdu
 */
			if ( m_SnmpTooBig )
			{
/*
 * PDU TOO BIG
 */
				if ( m_VarBindsLeftBeforeTooBig == 0 )
				{
/*
 *	Set Error object for TooBig because we only sent one vb
 */
					
					t_Status = FALSE ;
				}
				else
				{
/*
 * Decrement the number of variable bindings so that we can avoid an SNMP TOO BIG response
 */

					m_VarBindsLeftBeforeTooBig -- ;

/*
 * Resend
 */
					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						m_VarBindsLeftBeforeTooBig , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: notInService 
					) ;

					state = 22 ;
				}
			}
			else
			{
/*
 *	We've either succeeded or totally failed to set the row as notInService
 */

				if ( t_Status = SUCCEEDED ( m_errorObject.GetWbemStatus () ) )
				{
/*
 *	Now send a non row status variable binding list
 */
					ULONG t_VarBindsPerPdu = 0 ;

					t_Status = GetAgentMaxVarBindsPerPdu ( m_errorObject , t_VarBindsPerPdu ) ;
					if ( t_Status ) 
					{
						m_VarBindsLeftBeforeTooBig = t_VarBindsPerPdu ;

						t_Status = Send_Variable_Binding_List ( 

							snmpObject , 
							m_VarBindsLeftBeforeTooBig
						) ;

						state = 23 ;
					}
					else
					{
						m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
						m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
						m_errorObject.SetMessage ( L"Internal Error" ) ;
						t_Status = FALSE ;
					}
				}
				else
				{
				}
			}
		}
		break ;

		case 23:
		{
/*
 * check to see if we succeeded in sending a non row status variable binding list
 */

			if ( m_SnmpTooBig )
			{
				if ( m_VarBindsLeftBeforeTooBig == 0 )
				{
/*
 *	Set Error object for TooBig because we only sent one vb
 */
					
					t_Status = FALSE ;
				}
				else
				{
					m_VarBindsLeftBeforeTooBig -- ;

					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						m_VarBindsLeftBeforeTooBig , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: notInService 
					) ;

					state = 23 ;
				}
			}
			else
			{
				ULONG t_VarBindsPerPdu = 0 ;

				if ( snmpObject.NumberOfWritable () == 0 )
				{
					t_Status = Send_Variable_Binding_List ( 

						snmpObject , 
						0 , 
						SnmpRowStatusType :: SnmpRowStatusEnum :: active 
					) ;

					state = 24 ;
				}
				else
				{
					ULONG t_VarBindsPerPdu = 0 ;

					t_Status = GetAgentMaxVarBindsPerPdu ( m_errorObject , t_VarBindsPerPdu ) ;
					if ( t_Status ) 
					{
						m_VarBindsLeftBeforeTooBig = t_VarBindsPerPdu ;

						t_Status = Send_Variable_Binding_List ( 

							snmpObject , 
							m_VarBindsLeftBeforeTooBig 
						) ;

						state = 23 ;
					}
					else
					{
						m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
						m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
						m_errorObject.SetMessage ( L"Internal Error" ) ;
						t_Status = FALSE ;
					}
				}
			}
		}
		break ;

		case 24:
		{
			if ( m_SnmpTooBig )
			{
				m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
				m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
				m_errorObject.SetMessage ( L"Agent could not process Set Request because SNMP PDU was too big" ) ;

				t_Status = FALSE ;
			}
			else
			{
				SetComplete () ;
				return ;
			}
		}
		break ;

		case 30:
		{
			if ( ! SUCCEEDED ( m_errorObject.GetStatus () ) )
			{
				SetComplete () ;
				return ;
			}

			if ( m_QueryOperation->GetRowReceived () == 0 )
			{
				t_Status = Update_Only () ;
			}
			else
			{
				t_Status = Create_Only () ;
			}
		}
		break ;

		default:
		{
			m_errorObject.SetStatus ( WBEM_SNMP_E_PROVIDER_FAILURE  ) ;
			m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
			m_errorObject.SetMessage ( L"UNKNOWN STATE TRANSITION" ) ;

			t_Status = FALSE ;
		}
		break ;
	}

	if ( t_Status == FALSE ) 
	{
		SetComplete () ;
	}

DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Returning from SnmpUpdateAsyncEventObject :: ReceiveComplete ()" 
	) ;
)
}

void SnmpUpdateAsyncEventObject :: SnmpTooBig () 
{
DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"SnmpUpdateAsyncEventObject :: SnmpTooBig ()" 
	) ;
)

	m_SnmpTooBig = TRUE ;

DebugMacro3( 

	SnmpDebugLog :: s_SnmpDebugLog->Write (  

		__FILE__,__LINE__,
		L"Returning from SnmpUpdateAsyncEventObject :: SnmpTooBig ()" 
	) ;
)
}

BOOL SnmpUpdateEventObject :: Create_Only ()
{
	BOOL t_Status = TRUE ;

/*
 *	V2C SMI ROWSTATUS - CREATE_ONLY
 */

	WbemSnmpProperty *t_Property ;
	snmpObject.ResetProperty () ;
	while ( t_Property = snmpObject.NextProperty () )
	{
		t_Property->SetTag ( FALSE ) ;
	}

	ULONG t_VarBindsPerPdu = 0 ;

	t_Status = GetAgentMaxVarBindsPerPdu ( m_errorObject , t_VarBindsPerPdu ) ;
	if ( t_Status ) 
	{
		m_VarBindsLeftBeforeTooBig = t_VarBindsPerPdu ;

		ULONG t_NumberOfWritable = snmpObject.NumberOfWritable () ;

/*
* Check to see if we can fit all vbs in to one pdu
*/
		if ( t_NumberOfWritable < t_VarBindsPerPdu )
		{

// Does fit
			t_Status = Send_Variable_Binding_List ( 

				snmpObject , 
				t_NumberOfWritable , 
				SnmpRowStatusType :: SnmpRowStatusEnum :: createAndGo 
			) ;

			state = 7 ;
		}
		else
		{
// Does not fit, therefore decompose

			t_Status = Send_Variable_Binding_List ( 

				snmpObject , 
				m_VarBindsLeftBeforeTooBig , 
				SnmpRowStatusType :: SnmpRowStatusEnum :: createAndWait 
			) ;

			state = 8 ;
		}
	}
	else
	{
		m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
		m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
		m_errorObject.SetMessage ( L"Internal Error" ) ;
		t_Status = FALSE ;
	}


	return t_Status ;
}

BOOL SnmpUpdateEventObject :: Update_Only ()
{
	BOOL t_Status = TRUE ;

/*
 *	V2C SMI ROWSTATUS - UPDATE_ONLY
 */

	WbemSnmpProperty *t_Property ;
	snmpObject.ResetProperty () ;
	while ( t_Property = snmpObject.NextProperty () )
	{
		t_Property->SetTag ( FALSE ) ;
	}

	ULONG t_VarBindsPerPdu = 0 ;

	t_Status = GetAgentMaxVarBindsPerPdu ( m_errorObject , t_VarBindsPerPdu ) ;
	if ( t_Status ) 
	{
		m_VarBindsLeftBeforeTooBig = t_VarBindsPerPdu ;

		ULONG t_NumberOfWritable = snmpObject.NumberOfWritable () ;

/*
 * Check to see if we can fit all vbs in to one pdu
 */
		if ( t_NumberOfWritable < t_VarBindsPerPdu )
		{

// Does fit
			t_Status = Send_Variable_Binding_List ( 

				snmpObject , 
				t_NumberOfWritable , 
				SnmpRowStatusType :: SnmpRowStatusEnum :: active 
			) ;

			state = 7 ;
		}
		else
		{
// Does not fit, therefore decompose

			t_Status = Send_Variable_Binding_List ( 

				snmpObject , 
				m_VarBindsLeftBeforeTooBig , 
				SnmpRowStatusType :: SnmpRowStatusEnum :: notInService
			) ;

			state = 8 ;
		}
	}
	else
	{
		m_errorObject.SetStatus ( WBEM_SNMP_E_TRANSPORT_ERROR ) ;
		m_errorObject.SetWbemStatus ( WBEM_E_FAILED ) ;
		m_errorObject.SetMessage ( L"Internal Error" ) ;
		t_Status = FALSE ;
	}

	return t_Status ;
}

BOOL SnmpUpdateEventObject :: Create_Or_Update ()
{
	BOOL t_Status = FALSE ;

	state = 30 ;
	t_Status = CheckForRowExistence ( m_errorObject ) ;

	return t_Status ;
}

BOOL SnmpUpdateEventObject :: Send_Variable_Binding_List ( 

	SnmpSetClassObject &a_SnmpSetClassObject , 
	ULONG a_NumberToSend 
)
{
/*
 * Find Property of RowStatus type and make sure we don't send in request
 */

	BOOL t_Status = FALSE ;

	WbemSnmpProperty *t_Property ;

	a_SnmpSetClassObject.ResetProperty () ;
	while ( t_Property = a_SnmpSetClassObject.NextProperty () )
	{
		if ( typeid ( *t_Property->GetValue () ) == typeid ( SnmpRowStatusType ) )
		{
			t_Property->SetTag ( TRUE ) ;
		}
	}

	t_Status = SendSnmp ( m_errorObject , a_NumberToSend ) ;

	return t_Status ;
}

BOOL SnmpUpdateEventObject :: Send_Variable_Binding_List ( 

	SnmpSetClassObject &a_SnmpSetClassObject , 
	ULONG a_NumberToSend ,
	SnmpRowStatusType :: SnmpRowStatusEnum a_SnmpRowStatusEnum
)
{
	BOOL t_Status = FALSE ;

	WbemSnmpProperty *t_Property ;

	a_SnmpSetClassObject.ResetProperty () ;
	while ( t_Property = a_SnmpSetClassObject.NextProperty () )
	{
		if ( typeid ( *t_Property->GetValue () ) == typeid ( SnmpRowStatusType ) )
		{
			t_Property->SetTag ( FALSE ) ;
			SnmpRowStatusType *t_RowStatus = new SnmpRowStatusType ( a_SnmpRowStatusEnum ) ;
			t_Property->SetValue ( t_RowStatus ) ;
		}
	}

	t_Status = SendSnmp ( m_errorObject , a_NumberToSend ) ;

	return t_Status ;
}
