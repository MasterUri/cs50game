﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelText : MonoBehaviour
{
    
    public static levelNum = 1;
    private Text levelText;

    // Start is called before the first frame update
    void Start()
    {
        levelText = gameObject.GetComponent<Text>();
    }

    // Update is called once per frame
    void Update()
    {
        string levelText.text = "Level: one";
    }
}
