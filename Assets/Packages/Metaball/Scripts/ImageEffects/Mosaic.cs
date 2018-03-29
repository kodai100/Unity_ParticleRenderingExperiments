using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mosaic : ImageEffectBase {

    [SerializeField]
    float _numBlocks = 10;
    
    
    protected override void UpdateShaderParams(Material material)
    {
        material.SetFloat("_BlockNum", _numBlocks);
    }


}
