project (
    'virgil', [ 'vala', 'c' ],
    version: '1.0.0',
)

# Variables
source_dir = meson.current_source_dir ()
vapi_dir = source_dir / 'vapi'
operating_system = build_machine.system ()

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

    'src/Graphics/Shader.vala',
    'src/Graphics/ShaderDataType.vala',
    'src/Graphics/Font.vala',

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
    # 'src/Asset.vala',
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
    'src/Runtime/FontCache.vala',
    'src/Runtime/AudioCache.vala',
    'src/Runtime/GameLoader.vala',

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
