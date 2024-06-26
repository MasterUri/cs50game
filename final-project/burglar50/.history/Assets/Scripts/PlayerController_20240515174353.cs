using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public bool facingRight = true;
    public bool bag = false;
    public bool hidden = false;
    public float speed = 10f;
    private float moveInput = 0f;

    float playerMove;

    public Animator animator;
    
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void FixedUpdate()
    {
        animator.SetBool("Bag", bag); //check if we have a bag
        DirectionCheck();
        
        if (hidden == false) {
            moveInput = Input.GetAxis("Horizontal");
        }

        playerMove = moveInput  * speed * Time.deltaTime;
        animator.SetFloat("Speed", playerMove);
        transform.Translate(new Vector3(playerMove, 0, 0));
    }

    // Check what direction we are facing
    void DirectionCheck(){
        if(playerMove > 0.01){
            facingRight = true;
        } else if(playerMove < -0.01){
            facingRight = false;
        }

        animator.SetBool("Facing_Right", facingRight);
    }
}
