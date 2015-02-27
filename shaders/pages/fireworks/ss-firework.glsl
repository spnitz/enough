uniform sampler2D t_oPos;
uniform sampler2D t_pos;
uniform sampler2D t_start;
uniform float dT;

uniform float exploded;
uniform float alive;

uniform vec3 target;
uniform vec3 direction;

uniform float explosion;
uniform float explosionType;

uniform float instant;
varying vec2 vUv;


$simplex
$curl

void main(){


  
  vec4 oPos = texture2D( t_oPos , vUv );
  vec4 pos  = texture2D( t_pos , vUv );

  vec3 vel  = pos.xyz - oPos.xyz;
  vec3 p    = pos.xyz;


  float life = pos.w;
  
  vec3 f = vec3( 0. , 0. , 0. );
  
  // Always restarting
  if( life < 0. ){
    life = 0.;
  }else{
    if( exploded > .5 ){
     // life += dT*10.* (abs(sin( vUv.x * 1000. * cos( vUv.y * 500. )))+4.) ;
    }
  }
  
 
  if( exploded > .5 ){
    
    //vec3 curl = curlNoise( pos.xyz * .1 );
    //f += curl* .05;
    f += vec3(0. , -.03 ,0.);
 
  }
 


  vel += f;
  vel *= .99;//dampening;



  if( life > 10. ){
   
   
    p = texture2D( t_start , vUv ).xyz + target.xyz;
     vel *= 0.;
     life = -1.;

  }

  if( life == 0. ){
 
    p = texture2D( t_start , vUv ).xyz * 1.2 + target.xyz;

    vel = direction;
   // vel *= 0.;

  }


  
  // We get 1 frame of explosion
  if( explosion > .1 ){
     

    vec3 esp = direction;
     

    //wha:
    //vec3( vUv.x , vUv.y , length( vUv ) );


    vel += esp * 3.; //+ direction;//vec3( vUv.x -.5, vUv.y-.5 , length( vUv )-1. ) * 3.;
  
 
    life = 1.;
   // vel += vec3( 0. , 1. , 0. );
  }
  
  p += vel * 1.;//speed;


  if( instant > .5 ){

     p = texture2D( t_start , vUv ).xyz + target.xyz;


  }

  if( exploded < .5 ){

    p = texture2D( t_start , vUv ).xyz + target.xyz;
    
   // p = texture2D( t_start , vUv ).xyz + target.xyz;

  }

  float esp = life;

  life += exploded * .1;
  life = clamp( life , 0. , 2. );
  
  gl_FragColor = vec4( p , life  );

}
