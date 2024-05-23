using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Lock : MonoBehaviour
{
    public bool locked = false;
    public static bool closed = true;
    public GameObject openedGraphic;
    public GameObject lockedGraphic = null;
    public GameObject tooltip;
    public GameObject lockUI = null;


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

            if (closed == false) {
                openedGraphic.SetActive(false);
                if (lockedGraphic != null) {
                    lockedGraphic.SetActive(true);
                }
                closed = !closed;
            } else {
                tooltip.SetActive(true);
            }
        }
    }

    private void OnTriggerStay2D(Collider2D other) {
        if (other.CompareTag("Player")){
            if (Input.GetKey(KeyCode.UpArrow) || Input.GetKey(KeyCode.W)) {
                if (locked){
                    lockUI.SetActive(true);
                    Time.timeScale = 0f;
                } else if (closed == true) {
                    openedGraphic.SetActive(true);
                    if (lockedGraphic != null){
                        lockedGraphic.SetActive(false);
                    }
                    closed = !closed;
                    tooltip.SetActive(false);
                }
            }
        }
    }

    private void OnTriggerExit2D(Collider2D other) {
        if (other.CompareTag("Player")){
            tooltip.SetActive(false);
        }
    }
}
