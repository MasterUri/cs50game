﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovingObjects : MonoBehaviour
{
    public bool horizontal = true;
    public bool odd = true;
    public bool finish = false; 
    float startingX;
    float startingY;
    float speed;

    // Start is called before the first frame update
    void Start()
    {
        speed = Random.value * 5;
        startingX = gameObject.transform.position.x;
        startingY = gameObject.transform.position.y;
        if (odd) {speed = -speed;}
    }

    // Update is called once per frame
    void Update()
    {
        if ((gameObject.transform.position.x >= (startingX + 2)) || (gameObject.transform.position.x <= (startingX - 2))
            || (gameObject.transform.position.y >= (startingY + 2)) || (gameObject.transform.position.y <= (startingY - 2))) {
                speed = -speed;
            }
        
        if (finish == false){
            if (horizontal) {
                gameObject.transform.Translate(Vector3.left * speed * Time.deltaTime);
            } else {
                gameObject.transform.Translate(Vector3.up * speed * Time.deltaTime);
            }
        }
       
    }
}
