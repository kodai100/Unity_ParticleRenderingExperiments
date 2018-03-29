Shader "MyEffect/Mosaic" {
	Properties {
		_MainTex("Texture", 2D) = "white" {}
		_BlockNum("Number Of Blocks", Float) = 10
	}
	
	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			uint _BlockNum;

			fixed4 frag(v2f_img i) : COLOR {
				fixed2 f = floor(i.uv * _BlockNum);
				fixed size = 1.0 / _BlockNum;
				fixed2 lb = f / _BlockNum; // left bottom
				fixed2 lt = lb + fixed2(0.0, size); // left top
				fixed2 rb = lb + fixed2(size, 0.0); //right bottom
				fixed2 rt = lb + fixed2(size, size); // right top
				fixed4 c = (tex2D(_MainTex, lb) + tex2D(_MainTex, lt) + tex2D(_MainTex, rb) + tex2D(_MainTex, rt)) / 4.0;
				return c;
			}

			ENDCG
		}
	}
}