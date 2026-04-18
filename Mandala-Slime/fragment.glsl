/* * ----------------------------------------------------------------------------
 * COPYRIGHT © 2026 
 * HECHO POR: nostalgic_future
 * LICENCIA: Creative Commons Attribution-NonCommercial-ShareAlike
 * ----------------------------------------------------------------------------
 * "Mandala Slime"
 * ----------------------------------------------------------------------------
 */


#define loop 5.0


vec3 palette(float t) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263, 0.430, 0.500); 
    return a + b * cos(9.28318 * (c * t + d));
}

float func(vec3 p, float t){
    float f = 0.0;
    float a  = atan(p.y,p.x)*3.;
    float d = length(p);
    
    p.xy *= mat2(cos(a+t*.8)*d,sin(a)*d,-sin(a)*d,cos(a+t*.7)*d);
    
    f+=length(sin(p));
    f*= sin(p.z+t+cos(length(p.xy)+t));
    f = abs(f);
    f = pow(f,p.z);
    f = sin(f*d+t);
    return f;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float t = iTime;
    
    fragCoord.xy -= iResolution.xy*.5;    
    vec2 uv = fragCoord.xy / iResolution.xx*20.0;
    
    float f = 0.3;
    float d_origin = length(uv);
    
    for(float i = 0.3; i < loop; i++){
        f += func(vec3(uv.x, uv.y, i * 0.1), t); 
    }
    
    f /= loop;
    
    vec3 color = palette(f + d_origin * 0.6 + t * 0.2);
    fragColor = vec4(color * f, 1.0);
}
