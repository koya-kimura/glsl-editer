#define PI 3.1415926535

float atan2(float y, float x){
    return x == 0. ? sign(y) * PI / 2. : atan(y, x);
}

vec2 xy2pol(vec2 xy){
    return vec2(atan2(xy.y, xy.x), length(xy));
}

vec2 pol2xy(vec2 pol){
    return pol.y * vec2(cos(pol.x), sin(pol.x));
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=fragCoord/iResolution.xy;
    uv -= 0.5;
    uv = xy2pol(uv);

    vec3 col=vec3(step(sin(uv.y*100.), 0.99));

    fragColor=vec4(col,1.);
}