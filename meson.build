project (
    'virgil', [ 'vala', 'c' ],
    version: '1.0.0',
    default_options: [
        'buildtype=release',
    ]
)

# Build defines
export_plugins = false

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
    '--vapidir', vapi_dir
]

cc_arguments = [ ]

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
    # PUBLIC API
    'src/Input/KeyCode.vala',
    'src/Input/MouseButton.vala',
    'src/Input/KeyboardInput.vala',
    'src/Input/MouseInput.vala',

    'src/GameObject.vala',
    'src/Component.vala',
    'src/Vector2.vala',
    'src/Rectangle.vala',
    'src/Colour.vala',
    'src/Transform.vala',
    'src/Texture2D.vala',
    'src/Shapes.vala',
    'src/Surface2D.vala',
    'src/Point.vala',
    'src/Game.vala',

    # PUBLIC COMPONENTS
    'src/Components/Camera2D.vala',
    'src/Components/TextureRenderer.vala',
    'src/Components/Collider2D.vala',
    'src/Components/CircleCollider2D.vala',
    'src/Components/RectangleCollider2D.vala',

    # RUNTIME API
    'src/Runtime/Window.vala',
    'src/Runtime/GameLoader.vala',
    'src/Runtime/Main.vala',
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
# NOTE: Need to run ninja twice to get here, maybe move to subproject
# if (import ('fs').is_file ('build/virgil.vapi'))
    shared_module (
        'game',

        files (
            'sandbox/Game.vala',
            'sandbox/Player.vala',
            'sandbox/Box.vala'
        ),

        name_prefix: '',

        dependencies: [
            valac.find_library ('virgil', dirs: meson.current_source_dir () / 'build'),
            dependency ('gmodule-2.0'), # Will include GLIB
        ]
    )
# endif
