project (
    'virgil', [ 'vala', 'c' ],
    version: 'devel',
)

# Variables
source_dir = meson.current_source_dir ()
vapi_dir = source_dir / 'vapi'
operating_system = build_machine.system ()

config_data = configuration_data ()

# Build variables
project_source = []
project_dependencies = []
project_include = []

# Compilers
valac = meson.get_compiler ('vala')
cc = meson.get_compiler ('c')

# Compiler arguments
valac_arguments = [
    '--vapidir=' + vapi_dir
]

cc_arguments = [ ]

if operating_system == 'windows' or operating_system == 'cygwin'
    config_data.set ('RUNTIME_PLATFORM', 'WIN32')
    config_data.set ('RUNTIME_GAME_FILE', 'game.dll')
elif operating_system == 'linux'
    config_data.set ('RUNTIME_PLATFORM', 'LINUX')
    config_data.set ('RUNTIME_GAME_FILE', 'game.so')
endif

config_data.set ('RUNTIME_VERSION', meson.project_version ())
config_data.set ('RUNTIME_C_COMPILER', cc.get_id ())
config_data.set ('RUNTIME_C_COMPILER_VERSION', cc.version ())

config_data.set ('RUNTIME_VALA_COMPILER', valac.get_id ())
config_data.set ('RUNTIME_VALA_COMPILER_VERSION', valac.version ())

config_header = configure_file (
    input: 'src/Runtime/Constants.vala.conf',
    output: 'Constants.vala',
    configuration: config_data
)

add_project_arguments (valac_arguments, language: 'vala')
add_project_arguments (cc_arguments, language: 'c')


project_source = files (
    # PUBLIC API
    'src/Input/KeyCode.vala',
    'src/Input/MouseButton.vala',
    'src/Input/KeyboardInput.vala',
    'src/Input/MouseInput.vala',

    'src/Graphics/Shader.vala',
    'src/Graphics/ShaderDataType.vala',
    'src/Graphics/Font.vala',

    'src/Shell/Window.vala',
    'src/Shell/WindowFlag.vala',
    'src/Shell/Cursor.vala',

    'src/Audio/Sound.vala',
    'src/Audio/Music.vala',

    'src/ColliderBody2D.vala',
    'src/GameObject.vala',
    'src/Component.vala',
    'src/Vector2.vala',
    'src/Vector3.vala',
    'src/Vector4.vala',
    'src/Rectangle.vala',
    'src/Colour.vala',
    'src/Transform.vala',
    'src/Texture2D.vala',
    'src/Animation2D.vala',
    'src/Shapes.vala',
    'src/Surface2D.vala',
    'src/Game.vala',

    # PUBLIC COMPONENTS
    'src/Camera2D.vala',
    'src/ColliderShape2D.vala',
    'src/TextureRenderer2D.vala',
    'src/Collider2D.vala',
    'src/CircleCollider2D.vala',
    'src/RectangleCollider2D.vala',

    # RUNTIME API
    'src/Runtime/Main.vala',
    'src/Runtime/Window.vala',
    'src/Runtime/GameLoader.vala',
    'src/Runtime/RuntimeData.vala',

    # NOTE: This is a bin fire
    'src/Runtime/CollisionScene.vala',
)

project_dependencies = [
    dependency ('gobject-2.0'),
    dependency ('gmodule-2.0'), # Will include GLIB

    valac.find_library ('raylib', dirs: vapi_dir),

    cc.find_library ('m'),
    cc.find_library ('raylib')
]

project_lib = executable (
    meson.project_name (),

    project_source,
    config_header,

    dependencies: [
        project_dependencies
    ],

    export_dynamic: true,

    vala_header: 'virgil.h',
    vala_vapi: 'virgil.vapi',
)

project_dependency = declare_dependency (
    link_with: project_lib, # Only needed for windows

    dependencies: [
        dependency ('gobject-2.0'),
        dependency ('gmodule-2.0'), # Will include GLIB

        # Used for syntax highlighting using VLS in the sandbox, not required and will be skipped
        valac.find_library ('virgil', dirs: meson.current_source_dir () / 'build', required: false)
    ]
)

shared_module (
    'game',

    files (
        'sandbox/Game.vala',
        'sandbox/Player.vala',
        'sandbox/Tree.vala',
        'sandbox/TestObject.vala',
    ),

    name_prefix: '',

    dependencies: project_dependency
)
