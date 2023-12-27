#define PI 3.1415926535

float atan2(float y,float x){
    return x==0.?sign(y)*PI/2.:atan(y,x);
}

vec2 xy2pol(vec2 xy){
    return vec2(atan2(xy.y,xy.x),length(xy));
}

vec2 pol2xy(vec2 pol){
    return pol.y*vec2(cos(pol.x),sin(pol.x));
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    float n = 20.;

    vec2 uv=fragCoord/iResolution.xy;
    vec2 newUv = vec2(0.);
    vec2 newNewUv=vec2(0.);

    newUv = floor(uv*n)/n;
    newNewUv = floor(uv*pow(n, 2.))/pow(n,2.);

    uv = fract(uv*n);
    uv -= .5;
    uv = xy2pol(uv);

    vec3 col = vec3(0.);

    col.r += abs(sin(uv.y*100.))*0.3;

    newUv -= .5;
    newUv = xy2pol(newUv);
    col.r += abs(sin(newUv.y*100.))*0.3;

    newNewUv-=.5;
    newNewUv=xy2pol(newNewUv);
    col.r += abs(sin(newNewUv.y*100.))*0.3;

    fragColor=vec4(col,1.);
}