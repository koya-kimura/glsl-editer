// 六角形を描く
// 参考文献 : https://qiita.com/edo_m18/items/37d8773a5295bc6aba3d
// 補助参考文献 : 内積の補足 https://youtu.be/j_zr0D656hM?si=UhqwQGq5hrW6gm7d

float random(vec2 st){
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=(fragCoord-.5*iResolution.xy)/min(iResolution.x,iResolution.y);
    uv*=4.;

    vec3 col=vec3(0);

    vec2 r=normalize(vec2(1.,1.73));
    vec2 h=r*.5;
    vec2 a=mod(uv,r)-h;
    vec2 b=mod(uv-h,r)-h;

    vec2 gv=length(a)<length(b)?a:b;
    vec2 id=uv-gv;

    col.b=length(id)*.2+pow(sin(length(id)+iTime),4.)*.1;

    col.r += random(floor(uv*50.)/100. + vec2(iTime)) * .03;
    col.g+=random(floor(uv*54.)/100.+vec2(iTime))*.07;
    col.b+=random(floor(uv*57.)/100.+vec2(iTime))*.05;

    fragColor=vec4(col,1.);
}