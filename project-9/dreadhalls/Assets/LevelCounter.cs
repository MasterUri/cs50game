using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelCounter : MonoBehaviour
{
    public static int levelNum = 0;
    // Start is called before the first frame update
    void Start()
    {
        levelNum += 1;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
