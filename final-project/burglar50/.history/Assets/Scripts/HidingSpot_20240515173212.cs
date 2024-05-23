using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class HidingSpot : MonoBehaviour
{
    public GameObject player;
    public GameObject spot;
    public GameObject spotBag;
    public GameObject tooltip;
    private PlayerController playerController;
    private SpriteRenderer playerSprite;
    private bool isInsideBounds = false

    private void Start() {
        playerController = player.GetComponent<PlayerController>();
        playerSprite = player.GetComponent<SpriteRenderer>();
    }

    private void OnTriggerEnter2D(Collider2D other) {
        if (other.CompareTag("Player")){
            
            tooltip.SetActive(true);
            isInsideBounds = true;

        }
    }

    private void Update() {
        if (isInsideBounds){
            if (Input.GetKey(KeyCode.UpArrow) || Input.GetKey(KeyCode.W)) {
                if (playerController.hidden == false){
                    if (playerController.bag == false){
                        spot.SetActive(true);
                    } else {
                        spotBag.SetActive(true);
                    }

                    playerSprite.enabled = false;
                    playerController.hidden = true;
                } else {
                    if (playerController.bag == true){
                        spot.SetActive(false);
                    } else {
                        spotBag.SetActive(false);
                    }
                    
                    playerSprite.enabled = true;
                    playerController.hidden = false;
                }
            }
        }
    }

    private void OnTriggerStay2D(Collider2D other) {
        if (other.CompareTag("Player")){
            
        }
    }

    private void OnTriggerExit2D(Collider2D other) {
        if (other.CompareTag("Player")){
            tooltip.SetActive(false);
            isInsideBounds = false;
        }
    }

    
}
