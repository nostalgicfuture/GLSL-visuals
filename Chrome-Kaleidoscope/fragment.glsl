/* * ----------------------------------------------------------------------------
 * COPYRIGHT © 2026 
 * HECHO POR: nostalgic_future
 * LICENCIA: Creative Commons Attribution-NonCommercial-ShareAlike
 * ----------------------------------------------------------------------------
 * "Chrome Kaleidoscope"
 * ----------------------------------------------------------------------------
 */

#define R(p,a,r) mix(a*dot(p,a),p,cos(r))+sin(r)*cross(p,a)
#define H(h) (cos((h)*6.3+vec3(10, -0.5, 12))*0.5+0.5) // Paleta Morado/Azulada

void mainImage(out vec4 O, vec2 C)
{
    O = vec4(0);
    vec3 p, q, r = iResolution,
    d = normalize(vec3((C * 2. - r.xy) / r.y, 1.2)); 
    
    float g = 0., e, s;

    for(float i = 0.; i < 70.; i++)
    {
        p = g * d;
        p.z += iTime * 2.0;
        float a = 15.0;
        p = mod(p - a, a * 2.) - a;
        s = 1.0;
        
        for(int j = 0; j < 6; j++) {
            p = 0.5 - abs(p);
            p.xy *= mat2(cos(iTime*0.1), sin(iTime*0.1), -sin(iTime*0.1), cos(iTime*0.1));
            
            p.x < p.z ? p = p.zyx : p;
            p.z < p.y ? p = p.xzy : p;
            
            e = 1.5 + sin(iTime * 0.1) * 0.1;
            p = abs(p) * e - vec3(2.0, 5.0, 1.0);
            s *= e;
        }
        e = length(p.yz) / s;
        g += e;
        vec3 metallicGlow = mix(vec3(0.7, 0.9, 0.8), vec3(0.4, 0.0, 0.8), 0.4);
        
        O.xyz += metallicGlow * (0.0005 / (e + 0.001));
        
        if(g > 50.0) break;
    }
    O.xyz = pow(O.xyz, vec3(1.2)); 
    O.xyz *= 1.9; 
    O.w = 1.0;
}
