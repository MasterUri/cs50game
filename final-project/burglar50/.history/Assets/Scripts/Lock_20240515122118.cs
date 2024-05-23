using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Lock : MonoBehaviour
{
    public bool locked = false;
    public bool closed = true;
    public bool safe = false;
    public GameObject openedGraphic;
    public GameObject lockedGraphic = null;

    private int[] passcode = new int[3];
    

    // Start is called before the first frame update
    void Start()
    {
        if (locked){
            for (int i = 0; i < passcode.Length; i++){
                passcode[i] = UnityEngine.Random.Range(1, 9);
                Debug.Log(passcode[i]);
            }
        } 
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter2D(Collider2D other) {
        if (other.CompareTag("Player")){
            Debug.Log(closed);
            if (locked){

            } else if (closed == true){
                openedGraphic.SetActive(true);
                if (lockedGraphic != null){
                    lockedGraphic.SetActive(false);
                }
                closed = !closed;
                
            } else {
                openedGraphic.SetActive(false);
                if (lockedGraphic != null){
                    lockedGraphic.SetActive(true);
                }
                closed = !closed;
            }
        }
    }
}
