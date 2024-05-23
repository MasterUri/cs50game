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
    private bool isInsideBounds = false;

    private void Start() {
        playerController = player.GetComponent<PlayerController>();
        playerSprite = player.GetComponent<SpriteRenderer>();
    }

    private void OnTriggerEnter2D(Collider2D other) {
        if (other.CompareTag("Player") && playerController.detected == false){
            
            tooltip.SetActive(true);
            isInsideBounds = true;

        }
    }

    private void Update() {
        if (isInsideBounds){
            if (Input.GetKeyDown(KeyCode.UpArrow) || Input.GetKeyDown(KeyCode.W)) {
                if (playerController.hidden == false){
                    if (playerController.bag == false){
                        spot.SetActive(true);
                    } else {
                        spotBag.SetActive(true);
                    }

                    playerSprite.enabled = false;
                    playerController.hidden = true;
                } else {
                    if (playerController.bag == false){
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

    private void OnTriggerExit2D(Collider2D other) {
        if (other.CompareTag("Player")){
            tooltip.SetActive(false);
            isInsideBounds = false;
        }
    }

    
}
