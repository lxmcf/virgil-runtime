project (
    'virgil', [ 'vala', 'c' ],
    version: '1.0.0',
    default_options: [
        # 'buildtype=release',
    ]
)

# Variables
source_dir = meson.current_source_dir ()
vapi_dir = source_dir / 'vapi'

# Build variables
project_source = []
project_dependency = []
project_include = []

# Compilers
valac = meson.get_compiler ('vala')
cc = meson.get_compiler ('c')

# Compiler arguments
valac_arguments = [
    '--vapidir', vapi_dir,
]

cc_arguments = [
    '-DSTB_IMAGE_IMPLEMENTATION'
]

add_project_arguments (valac_arguments, language: 'vala')
add_project_arguments (cc_arguments, language: 'c')

project_source = files (
    # ENTRY POINT
    'src/Main.vala',

    # PUBLIC API
    'src/Scenes/SceneManager.vala',
    'src/Scenes/Scene.vala',

    'src/Input/KeyCode.vala',
    'src/Input/MouseButton.vala',
    'src/Input/KeyboardInput.vala',
    'src/Input/MouseInput.vala',

    'src/Script.vala',
    'src/GameObject.vala',
    'src/Vector2.vala',
    'src/Texture2D.vala',
    'src/Surface2D.vala',
    'src/Point.vala',
    'src/Game.vala',

    # PUBLIC INTERFACES

    # INTERNAL API
    'src/Engine/Window.vala',
    'src/Engine/EngineState.vala',
    'src/Engine/GameLoader.vala',
    'src/Engine/InputManager.vala',
    'src/Engine/TextureManager.vala',
)

project_dependency = [
    dependency ('gobject-2.0'),
    dependency ('gmodule-2.0'), # Will include GLIB
    dependency ('SDL2'),

    cc.find_library ('m'),
    valac.find_library ('stb_image', dirs: vapi_dir)
]

temp_lib = executable (
    meson.project_name (),

    project_source,

    dependencies: [
        project_dependency
    ],

    include_directories: [
        include_directories ('include')
    ],

    export_dynamic: true,

    vala_header: 'virgil.h',
    vala_vapi: 'virgil.vapi'
)

# HACK: intellisense for the sandbox
vapi_dep = []

if (import ('fs').is_file ('build/virgil.vapi'))
    vapi_dep = [ valac.find_library ('virgil', dirs: meson.current_source_dir () / 'build') ]
endif

shared_module (
    'game',

    files (
        'sandbox/Game.vala'
    ),

    name_prefix: '',
    link_with: temp_lib,

    dependencies: [
        project_dependency,
        vapi_dep
    ],

    include_directories: [
        include_directories('.')
    ]
)