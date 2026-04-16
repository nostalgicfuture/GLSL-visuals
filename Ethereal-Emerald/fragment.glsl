// HECHO POR: nostalgic_future
// "Ethereal Emerald" (Volumetric Raymarching)

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 res = iResolution.xy;
    vec2 u = (fragCoord + fragCoord - res) / res.y;

    float t = iTime * 1.9;
    float d = 0.0, s = 0.0, r = 0.0;
    vec4 o = vec4(0.0);
    for (float i = 0.0; i < 100.0; i++) {
        s = 0.003 + abs(s) * 0.35;
        d += s;
        o.r += sin(d * 0.7 + t) * 0.6 / s;
        o.g += abs(cos(d * 0.4)) * 0.5 / s;
        o.b += sin(d * 0.30 - t) * 1.9 / s;

        vec3 p = vec3(u * d, d + t * 5.0);
        float breathe = 1.9 + sin(t) * 0.2;
        s = min(p.z, breathe + sin(p.z * 1.2) * 0.2);
        r = p.z * 0.1 + t * 0.2;
        float c = cos(r), sn = sin(r);
        p.xy *= mat2(c, -sn, sn, c);
        p += cos(t * 0.6 - p.yzx * 0.6 + vec3(1, 2, 3)) * 0.2;
        s += abs(sin(p.x)) * 2.5 * -abs(sin(p.y));
    }

    o = pow(tanh(o * o / 1.3e8 * length(u)), vec4(0.40));
    fragColor = o;
}
