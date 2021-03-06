<?xml version="1.0" encoding="UTF-16"?>
<!DOCTYPE DCARRIER SYSTEM "Mantis.DTD">

  <DCARRIER
    CarrierRevision="1"
    DTDRevision="16"
  >
    <TASKS
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </TASKS>

    <PLATFORMS
      Context="1"
    >    </PLATFORMS>

    <REPOSITORIES
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </REPOSITORIES>

    <GROUPS
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >
      <GROUP
        GroupVSGUID="{6072a3e4-aa50-4662-80f4-8c59e5625741}"
        Revision="721"
        GroupClass="Dependency"
        DefaultDependencyType="AtLeastOne"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >        </PROPERTIES>

        <SECONDARYPLATFORMS
        >        </SECONDARYPLATFORMS>

        <DISPLAYNAME>Greek Language Extended Support</DISPLAYNAME>

        <VERSION>5.1.2600</VERSION>

        <DESCRIPTION>This dependency group contains any additional NLS components that support Greek Language.</DESCRIPTION>

        <COPYRIGHT>Copyright © 2001 Microsoft Corporation</COPYRIGHT>

        <VENDOR>Microsoft Corporation</VENDOR>

        <OWNERS>Microsoft</OWNERS>

        <AUTHORS>Microsoft</AUTHORS>

        <DATECREATED>7/26/2002 6:14:58 PM</DATECREATED>

        <DATEREVISED>7/26/2002 6:14:58 PM</DATEREVISED>
      </GROUP>

      <GROUP
        GroupVSGUID="{768de114-bb26-4a7e-8cf8-7a00d44089bf}"
        Revision="721"
        GroupClass="Dependency"
        DefaultDependencyType="All"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >        </PROPERTIES>

        <SECONDARYPLATFORMS
        >        </SECONDARYPLATFORMS>

        <DISPLAYNAME>Greek Locales Group</DISPLAYNAME>

        <VERSION>5.1.2600</VERSION>

        <DESCRIPTION>This dependency group contains user and system locale components that support Greek Language.</DESCRIPTION>

        <COPYRIGHT>Copyright © 2001 Microsoft Corporation</COPYRIGHT>

        <VENDOR>Microsoft Corporation</VENDOR>

        <OWNERS>Microsoft</OWNERS>

        <AUTHORS>Microsoft</AUTHORS>

        <DATECREATED>7/26/2002 6:14:58 PM</DATECREATED>

        <DATEREVISED>7/26/2002 6:14:58 PM</DATEREVISED>
      </GROUP>
    </GROUPS>

    <COMPONENTS
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >
      <COMPONENT
        ComponentVSGUID="{E187F095-2A8F-414F-BD26-5F62DA9929D3}"
        ComponentVIGUID="{52FA33D8-6A95-492A-8BC2-C1C3D7753207}"
        Revision="721"
        PrototypeVIGUID="{87899248-F1AA-4037-99A7-81B6DD1AFEB4}"
        RepositoryVSGUID="{8E0BE9ED-7649-47F3-810B-232D36C430B4}"
        Visibility="1000"
        MultiInstance="False"
        Released="False"
        Editable="True"
        HTMLFinal="False"
        IsMacro="False"
        Opaque="False"
        Context="1"
        PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
      >
        <PROPERTIES
          Context="1"
          PlatformGUID="{00000000-0000-0000-0000-000000000000}"
        >
          <PROPERTY
            Name="cmiLangEnableAllSystemLocales"
            Format="Boolean"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >True</PROPERTY>

          <PROPERTY
            Name="cmiLangExtendedSupportShared"
            Format="GUID"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >{B463E505-2792-45FA-9EF0-02D364AC234F}</PROPERTY>

          <PROPERTY
            Name="cmiLangExtendedSupport"
            Format="GUID"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >{6072A3E4-AA50-4662-80F4-8C59E5625741}</PROPERTY>

          <PROPERTY
            Name="cmiLangName"
            Format="String"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >Greek</PROPERTY>

          <PROPERTY
            Name="cmiLangId"
            Format="Integer"
            Context="1"
            PlatformGUID="{00000000-0000-0000-0000-000000000000}"
          >8</PROPERTY>
        </PROPERTIES>

        <RESOURCES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >        </RESOURCES>

        <GROUPMEMBERS
        >
          <GROUPMEMBER
            GroupVSGUID="{8180C915-788C-473C-80BB-BB6DF8FFA263}"
          ></GROUPMEMBER>

          <GROUPMEMBER
            GroupVSGUID="{A1A56917-46F2-492E-A544-C4EB1B95F61E}"
          ></GROUPMEMBER>

          <GROUPMEMBER
            GroupVSGUID="{719FF4F5-55C2-4A87-A744-19E6C9B3089F}"
          ></GROUPMEMBER>
        </GROUPMEMBERS>

        <DEPENDENCIES
          Context="1"
          PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
        >
          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{475D8A7D-524C-46AA-B416-6B12E559D69E}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>1253  (ANSI - Greek)</DISPLAYNAME>

            <DESCRIPTION>1253  (ANSI - Greek)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{FB0E56A0-47B0-4CEB-92D3-993928127254}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>10006 (MAC - Greek I)</DISPLAYNAME>

            <DESCRIPTION>10006 (MAC - Greek I)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{06CF9051-7D97-41A8-9CBC-381908548BFB}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>20423 (IBM EBCDIC - Greek)</DISPLAYNAME>

            <DESCRIPTION>20423 (IBM EBCDIC - Greek)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{873CC354-A427-49EB-B07E-BF13A02A780C}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>28597 (ISO 8859-7 Greek)</DISPLAYNAME>

            <DESCRIPTION>28597 (ISO 8859-7 Greek)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{8F651155-E2BB-49BC-ACC2-99A05F68BB9F}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>875   (IBM EBCDIC - Modern Greek)</DISPLAYNAME>

            <DESCRIPTION>875   (IBM EBCDIC - Modern Greek)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="All"
            DependOnGUID="{72C84663-0421-4111-8B95-E43C114D378B}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1</PROPERTY>

              <PROPERTY
                Name="cmiLangRequired"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >True</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Greek bitmap fonts</DISPLAYNAME>

            <DESCRIPTION>Greek bitmap fonts</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{49045094-BCEF-4B17-9414-F92942C198D8}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >3</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Greek (220 Latin)</DISPLAYNAME>

            <DESCRIPTION>Greek (220 Latin)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{42E83997-4D17-405F-9C62-D2189309A30C}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >3</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Greek (220)</DISPLAYNAME>

            <DESCRIPTION>Greek (220)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{2A9C1DDE-6CDD-4E13-A7A7-17F1ECF59E58}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >3</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Greek (319 Latin)</DISPLAYNAME>

            <DESCRIPTION>Greek (319 Latin)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{A20653E5-958B-4055-8CA2-177E5624DDF2}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >3</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Greek (319)</DISPLAYNAME>

            <DESCRIPTION>Greek (319)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{B3187821-0083-4344-A373-6ECDB157D8F6}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >3</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Greek (Latin)</DISPLAYNAME>

            <DESCRIPTION>Greek (Latin)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{AC52AD22-9066-465C-95A8-8B5CC3B1389B}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >3</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Greek Polytonic</DISPLAYNAME>

            <DESCRIPTION>Greek Polytonic</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{2A5E8BA4-7632-43C0-AED5-A00580FBCEA8}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >3</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Greek</DISPLAYNAME>

            <DESCRIPTION>Greek</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{70E63B3A-8350-4A67-844E-3AD66B029A21}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >6</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>User Locale: 0408</DISPLAYNAME>

            <DESCRIPTION>User Locale: 0408</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{E6F64320-6CFE-434D-A598-12036F951BD8}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangLocaleId"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >1032</PROPERTY>

              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >7</PROPERTY>

              <PROPERTY
                Name="cmiLangInputProp"
                Format="String"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >cmiLangEnableAllSystemLocales</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Greek - 0408</DISPLAYNAME>

            <DESCRIPTION>Greek - 0408</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{7C5887A6-0A8C-40C3-A934-EABF9E72D56C}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>737   (OEM - Greek 437G)</DISPLAYNAME>

            <DESCRIPTION>737   (OEM - Greek 437G)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{E400E9D1-82BC-49E3-AFFB-3A0A23AD7BFB}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >2</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>869   (OEM - Modern Greek)</DISPLAYNAME>

            <DESCRIPTION>869   (OEM - Modern Greek)</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="AtLeastOne"
            DependOnGUID="{FADEEF60-2CDE-4453-8A52-614779819D9F}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >
              <PROPERTY
                Name="cmiLangModuleType"
                Format="Integer"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >5</PROPERTY>

              <PROPERTY
                Name="cmiLangDependOnSystemLocale"
                Format="Boolean"
                Context="1"
                PlatformGUID="{00000000-0000-0000-0000-000000000000}"
              >True</PROPERTY>
            </PROPERTIES>

            <DISPLAYNAME>Font Substitute dependency: Fonts_Greek_font_substitute</DISPLAYNAME>

            <DESCRIPTION>This component dependends on font substitute Fonts_Greek_font_substitute</DESCRIPTION>
          </DEPENDENCY>

          <DEPENDENCY
            Class="Include"
            Type="All"
            DependOnGUID="{768DE114-BB26-4A7E-8CF8-7A00D44089BF}"
            MinRevision="0"
            Disabled="False"
            Context="1"
            PlatformGUID="{B784E719-C196-4DDB-B358-D9254426C38D}"
          >
            <PROPERTIES
              Context="1"
              PlatformGUID="{00000000-0000-0000-0000-000000000000}"
            >            </PROPERTIES>

            <DISPLAYNAME>Dependency on user and system locale components</DISPLAYNAME>

            <DESCRIPTION>Dependency on user and system locale components</DESCRIPTION>
          </DEPENDENCY>
        </DEPENDENCIES>

        <SECONDARYPLATFORMS
        >        </SECONDARYPLATFORMS>

        <DISPLAYNAME>Greek Language Support</DISPLAYNAME>

        <VERSION>5.1.2600.1</VERSION>

        <DESCRIPTION>This component contains all necessary modules to support Greek language.</DESCRIPTION>

        <COPYRIGHT>Copyright © 2001 Microsoft Corporation</COPYRIGHT>

        <VENDOR>Microsoft Corporation</VENDOR>

        <OWNERS>Microsoft</OWNERS>

        <AUTHORS>Microsoft</AUTHORS>

        <DATECREATED>7/26/2002 6:14:58 PM</DATECREATED>

        <DATEREVISED>7/26/2002 6:14:58 PM</DATEREVISED>
      </COMPONENT>
    </COMPONENTS>

    <RESTYPES
      Context="1"
      PlatformGUID="{00000000-0000-0000-0000-000000000000}"
    >    </RESTYPES>
  </DCARRIER>
