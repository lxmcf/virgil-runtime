#shader vertex
#version 330

// Input vertex attributes
in vec3 vertexPosition;
in vec2 vertexTexCoord;
in vec3 vertexNormal;
in vec4 vertexColor;

// Input uniform values
uniform mat4 mvp;

// Output vertex attributes (to fragment shader)
out vec2 fragTexCoord;
out vec4 fragColor;

// NOTE: Add here your custom variables

void main () {
    // Send vertex attributes to fragment shader
    fragTexCoord = vertexTexCoord;
    fragColor = vertexColor;

    // Calculate final vertex position
    gl_Position = mvp * vec4 (vertexPosition, 1.0);
}

#shader fragment
#version 330

// Input vertex attributes (from vertex shader)
in vec2 fragTexCoord;
in vec4 fragColor;

// Input uniform values
uniform sampler2D texture0;
uniform vec4 colDiffuse;

// Output fragment color
out vec4 finalColor;

// NOTE: Add here your custom variables

void main () {
    // Texel color fetching from texture sampler
    vec4 texelColor = texture (texture0, fragTexCoord) * colDiffuse * fragColor;

    // Convert texel color to grayscale using NTSC conversion weights
    float gray = dot (texelColor.rgb, vec3 (0.299, 0.587, 0.114));

    // Calculate final fragment color
    finalColor = vec4 (gray, gray, gray, texelColor.a);
}
