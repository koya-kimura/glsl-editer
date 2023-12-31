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

    float r = .7;
    vec2 p = vec2(.5+r*pow(sin(iTime*1.3), 3.), .5+r*pow(sin(iTime*1.7), 3.));

    float l = length(p - uv);

    float s = pow(sin(iTime/2.), 2.)*1.2;

    float v = pow(s-l,3.);

    vec3 col= vec3(v, pow(v,2.), 0.);

    fragColor=vec4(col,1.);
}