vec3 palette(float t){
    vec3 a=vec3(.5,.5,.5);
    vec3 b=vec3(.5,.5,.5);
    vec3 c=vec3(1.,1.,1.);
    vec3 d=vec3(.263,.416,.557);

    return a+b*cos(6.28318*(c*t+d));
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=(fragCoord*2.-iResolution.xy)/iResolution.y;
    vec2 uv0=uv;
    vec3 finalColor=vec3(0.);

    for(float i=0.;i<3.;i++){
        uv=fract(uv*1.5)-.5;

        float d=length(uv)*exp(-length(uv0));

        vec3 col=palette(length(uv0)+iTime*.4);

        d=sin(d*8.+iTime)/8.;
        d=abs(d);

        d=.01/d;

        col*=d;
        finalColor+=col*d;
    }

    fragColor=vec4(finalColor,1.);
}