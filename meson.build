project (
    'virgil', [ 'vala', 'c' ],
    version: '1.0.0',
    default_options: [
        'buildtype=release',
    ]
)

# Variables
source_dir = meson.current_source_dir ()
vapi_dir = source_dir / 'vapi'
operating_system = build_machine.system ()

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
    '--ccode'
]

cc_arguments = [
    '-DSTB_IMAGE_IMPLEMENTATION'
]


if operating_system == 'windows' or operating_system == 'cygwin'
    valac_arguments += '--define=VIRGIL_PLATFORM_WINDOWS'
elif operating_system == 'linux'
    valac_arguments += '--define=VIRGIL_PLATFORM_LINUX'
elif
    valac_arguments += '--define=VIRGIL_PLATFORM_UNKNOWN'
endif

add_project_arguments (valac_arguments, language: 'vala')
add_project_arguments (cc_arguments, language: 'c')

project_source = files (
    # ENTRY POINT
    'src/Main.vala',

    # PUBLIC API
    'src/Scenes/Scene.vala',

    'src/Input/KeyCode.vala',
    'src/Input/MouseButton.vala',
    'src/Input/KeyboardInput.vala',
    'src/Input/MouseInput.vala',

    'src/Script.vala',
    'src/HashMap.vala',
    'src/GameObject.vala',
    'src/Vector2.vala',
    'src/Transform.vala',
    'src/Texture2D.vala',
    'src/Surface2D.vala',
    'src/Point.vala',
    'src/Game.vala',

    # PUBLIC INTERFACES

    # PUBLIC RUNTIME API

    # INTERNAL API
    'src/Engine/Window.vala',
    'src/Engine/GameLoader.vala',
    'src/Engine/SceneManager.vala',

    # INTERNAL INTERFACES
    # 'src/Engine/Interface/ICreateble.vala',
    # 'src/Engine/Interface/IDrawable.vala',
    # 'src/Engine/Interface/IRunnable.vala',
)

project_dependency = [
    dependency ('gobject-2.0'),
    dependency ('gmodule-2.0'), # Will include GLIB

    valac.find_library ('raylib', dirs: vapi_dir),

    cc.find_library ('m'),
    cc.find_library ('raylib')
]

temp_lib = executable (
    meson.project_name (),

    project_source,

    dependencies: [
        project_dependency
    ],

    export_dynamic: true,

    vala_header: 'virgil.h',
    vala_vapi: 'virgil.vapi'
)

# HACK: Intellisense for the sandbox
# NOTE: Need to run ninja twice to get here...
vapi_dep = []

if (import ('fs').is_file ('build/virgil.vapi'))
    vapi_dep = [ valac.find_library ('virgil', dirs: meson.current_source_dir () / 'build') ]

    shared_module (
        'game',

        files (
            'sandbox/Game.vala'
        ),

        name_prefix: '',

        dependencies: [
            vapi_dep,
            dependency ('gmodule-2.0'), # Will include GLIB
        ],

        include_directories: [
            include_directories('.')
        ]
    )
endif
