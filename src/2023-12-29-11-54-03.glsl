#iChannel1"https://66.media.tumblr.com/tumblr_mcmeonhR1e1ridypxo1_500.jpg"

#define PI 3.1415926535

float random(vec2 st){
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

mat2 rot(float angle){
    return mat2(cos(angle),-sin(angle),sin(angle),cos(angle));
}

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
    vec2 uv=fragCoord/iResolution.xy;
    uv = (uv-0.5)*2.;

    float l = length(uv);

    uv *= rot(PI/l + iTime);

    // uv = fract(uv*10.);

    vec4 col = texture2D(iChannel1, uv);

    fragColor=col;
}