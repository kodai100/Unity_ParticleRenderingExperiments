using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
public class UpSampler : MonoBehaviour
{

    [SerializeField]
    Shader _shader;

    [SerializeField]
    RenderTexture _resultTexture;


    private Material _material;

    protected void Start()
    {
        _material = new Material(_shader);
        
    }


    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {

        Graphics.Blit(_resultTexture, destination, _material);
    }


}