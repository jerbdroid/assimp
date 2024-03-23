project "AssetImporter"
	kind "StaticLib"
	language "C++"
    cppdialect "C++17"
    staticruntime "on" 


	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    prebuildcommands 
    {
        -- run cmake to generate dynamic files before building the project
        "cmake CMakeLists.txt"
    }

    defines
    {
        "ASSIMP_BUILD_NO_C4D_IMPORTER",
        "ASSIMP_BUILD_NO_IFC_IMPORTER", 
        "RAPIDJSON_HAS_STDSTRING",
        "RAPIDJSON_NOMEMBERITERATORCLASS",
        "STB_USE_HUNTER",
        "OPENDDLPARSER_BUILD"
    }

    files
	{
		"include/**/*.h",  
        "code/**/*.cpp", 
        "code/**/*.h", 
        "contrib/clipper/**",
        "contrib/Open3DGc/**",
        "contrib/openddlparser/**",
        "contrib/poly2tri/**",
        "contrib/pugixml/**",
        "contrib/unzip/**",
        "contrib/zlib/*.c",
        "contrib/zlib/**/*.c"
	}

    removefiles { 
        "contrib/zlib/contrib/inflate86/**"
    }

    includedirs 
    {
        ".",
        "include",
        "code",
        "contrib/zlib",
        "contrib/pugixml/src",
        "contrib/openddlparser/include",
        "contrib/rapidjson/include",
        "contrib/",
        "contrib/unzip",
        "%{IncludeDirectory.stb}",
    } 

    filter "system:windows"
        systemversion "latest"

    filter  "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter  "configurations:Release"
        runtime "Release"
        optimize "on"

    filter { "not action:vs*" }
		-- Set the tools explicitly
		toolset "clang"