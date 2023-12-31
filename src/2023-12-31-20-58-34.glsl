#define PI 3.1415926535

#iChannel1 "https://2.bp.blogspot.com/-sCYd5MsquF4/VCOJS6eoLvI/AAAAAAAAmvE/EDFPg_-YdmQ/s800/eto_mark04_usagi.png"
#iChannel2 "https://1.bp.blogspot.com/-7OzCCLysaWY/VCOJTY7fF5I/AAAAAAAAmvY/HqoY2F8aEqA/s800/eto_mark05_tatsu.png"

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
    uv = floor(uv*100.)/100.;

    vec4 col1 = texture2D(iChannel1, uv);

    vec4 col2 = texture2D(iChannel2,uv);

    vec4 col = vec4(1.);

    float a = 1.-mod(iTime/10.,1.);
    col.rgb = uv.y < a ? col1.rgb : col2.rgb;

    fragColor=col;
}