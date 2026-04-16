/* * ----------------------------------------------------------------------------
 * COPYRIGHT © 2026 
 * HECHO POR: nostalgic_future
 * ----------------------------------------------------------------------------
 * Vibe: Cybercore Y2K / Liquid Metal / con Glow Integrado
 */

mat2 rot(float a) {
    return mat2(cos(a), sin(a), -sin(a), cos(a));
}


float map(vec3 p) {
    float t = iTime * 0.7;
  
    p.xz *= rot(t * 0.2);
    p.xy *= rot(t * 0.3);
    
  
    float noise = sin(p.x + t) * sin(p.y + t * 0.8) * sin(p.z + t * 2.5);
    

    vec3 q = abs(mod(p, 4.0) - 2.0);
    float d = length(q.xz) - 0.2 + noise * 0.4;
    
    return d * 0.6;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    float t = iTime;


    vec3 ro = vec3(sin(t * 0.4) * 7.0, cos(t * 0.6) * 4.0, -5.0);
    vec3 rd = normalize(vec3(uv, 1.2));
    rd.xy *= rot(sin(t * 0.1) * 0.5);

    float totalDist = 0.0;
    float d, glow = 0.0;
    vec3 p;
    
   
    for(int i = 0; i < 80; i++) {
        p = ro + rd * totalDist;
        d = map(p);
        
    
        glow += 0.018 / (0.02 + abs(d)); 
        
        if(d < 0.001 || totalDist > 40.0) break;
        totalDist += d;
    }

    
    vec3 col = mix(vec3(0.0, 0.05, 0.1), vec3(0.0, 0.2, 0.4), uv.y + 0.5);

    if(d < 0.001) {
        vec2 e = vec2(0.01, 0.0);
        vec3 n = normalize(vec3(
            map(p + e.xyy) - map(p - e.xyy),
            map(p + e.yxy) - map(p - e.yxy),
            map(p + e.yyx) - map(p - e.yyx)
        ));

      
        vec3 ref = reflect(rd, n);
        float spec = pow(max(dot(ref, vec3(0, 1, 0)), 0.0), 50.0);
        float fresnel = pow(1.0 + dot(rd, n), 3.0);
        
        vec3 silver = vec3(0.8, 0.8, 0.9);
        vec3 aquaticBlue = vec3(0.0, 0.5, 0.8);
        
        col = mix(silver, aquaticBlue, fresnel);
        col += spec * 0.8; 
    }

  
    vec3 glowColor = vec3(0.0, 0.6, 1.0);
    col += glowColor * glow * 0.12; 
    col *= exp(-0.05 * totalDist);
    col = smoothstep(0.0, 1.1, col);
    
    fragColor = vec4(col, 2.0);
}
