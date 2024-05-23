using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HidingSpot : MonoBehaviour
{
    public GameObject player;
    public GameObject spot;
    public GameObject spotBag;
    public GameObject tooltip;

    private void Start() {
        player = GetComponent<GameObject>();
    }

    private void OnTriggerEnter2D(Collider2D other) {
        if (other.CompareTag("Player")){
            
            tooltip.SetActive(true);

        }
    }

    private void OnTriggerStay2D(Collider2D other) {
        if (other.CompareTag("Player")){
            if (Input.GetKey(KeyCode.UpArrow) || Input.GetKey(KeyCode.W)) {
                if (player.hidden == false){
                    
                } else {
                   
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
