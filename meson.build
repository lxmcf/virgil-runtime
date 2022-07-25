project ('virgil', [ 'vala', 'c' ], version: '1.0.0')

# Variables
source_dir = meson.current_source_dir ()
vapi_dir = source_dir / 'vapi'

# build variables
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

cc_arguments = [
    '-DSTB_IMAGE_IMPLEMENTATION'
]

add_project_arguments (valac_arguments, language: 'vala')
add_project_arguments (cc_arguments, language: 'c')

project_source = files (
    'src/main.vala',

    'src/Runtime/Window.vala',
)

project_dependency = [
    dependency ('glib-2.0'),
    dependency ('gobject-2.0'),
    dependency ('SDL2'),

    cc.find_library ('m')
]

# Used for testing
executable (
    meson.project_name (),

    project_source,

    dependencies: [
        project_dependency
    ]
)