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
    

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter2D(Collider2D other) {
        if (other.CompareTag("Player")){

            if (closed == false) {
                OpenDoor();
            } else {
                tooltip.SetActive(true);
            }
        }
    }

    private void OnTriggerStay2D(Collider2D other) {
        if (other.CompareTag("Player")){
            if (Input.GetKey(KeyCode.UpArrow) || Input.GetKey(KeyCode.W)) {
                if (locked){
                    GameController.PauseGame();
                    lockUI.SetActive(true);
                } else if (closed == true) {
                    OpenDoor();
                }
            }
        }
    }

    private void OnTriggerExit2D(Collider2D other) {
        if (other.CompareTag("Player")){
            tooltip.SetActive(false);
        }
    }

    public void OpenDoor(){
        openedGraphic.SetActive(closed);
        if (lockedGraphic != null){
            lockedGraphic.SetActive(!closed);
        }
        tooltip.SetActive(!closed);
        closed = !closed;
    }
}
