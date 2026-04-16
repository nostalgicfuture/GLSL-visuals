/* * ----------------------------------------------------------------------------
 * COPYRIGHT © 2026 
 * HECHO POR: nostalgic_future
 * LICENCIA: Creative Commons Attribution-NonCommercial-ShareAlike
 * ----------------------------------------------------------------------------
 * "Metal Nostalgic"
 * ----------------------------------------------------------------------------
 */


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
   
    vec2 uv = (fragCoord - 0.9 * iResolution.xy) / iResolution.y;

    float t = iTime * 0.8;

 
    vec2 p = uv;
    for(int i = 0; i < 3; i++){
        p += 0.22 * sin(p.yx * 3.0 + t);
        p *= 1.2;
    }

    float h = sin(p.x * 1.0) * sin(p.y * 6.0);

 
    vec2 e = vec2(0.002, 0.0);
    float hx = sin((p.x + e.x) * 6.0) * sin(p.y * 6.0);
    float hy = sin(p.x * 6.0) * sin((p.y + e.x) * 6.0);

    vec3 n = normalize(vec3(h - hx, h - hy, 0.15));
    vec3 lightPos = vec3(0.5 * cos(t), 0.5 * sin(t), 1.0);
    vec3 l = normalize(lightPos);

    float diff = max(dot(n, l), 0.0);
    float spec = pow(max(dot(reflect(-l, n), vec3(0,0,1)), 0.0), 32.0);

    vec3 purple = vec3(0.1, 0.2, 0.9);
    vec3 pink  = vec3(1.9, 0.5, 0.6);

    vec3 baseCol = mix(purple, pink, 0.5 + 0.5 * sin(h * 4.0 + t));

    vec3 col = baseCol * diff * 1.8 + spec * vec3(1.0, 0.8, 1.0);

    col = sqrt(col);

    fragColor = vec4(col, 1.0);
}
