using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController : MonoBehaviour
{
    public bool facingRight = true;
    public float speed = 5f;
    public bool alert;
    
    private float enemyMove;

    public GameObject detectionRight;
    public GameObject detectionLeft;
    private Collider2D detectorRight;
    private Collider2D detectorLeft;
    public GameObject waypoint1;
    public GameObject waypoint2;
    public PlayerController playerController = null;
    public Animator animator;
    

    // Start is called before the first frame update
    void Start()
    {
        detectorRight = detectionRight.GetComponent<Collider2D>();
        detectorLeft = detectionLeft.GetComponent<Collider2D>();
    }

    // Update is called once per frame
    void Update()
    {
        DirectionCheck();
        if (facingRight) {
            detectionLeft.SetActive(false);
            detectionRight.SetActive(true);
        } else {
            detectionLeft.SetActive(true);
            detectionRight.SetActive(false);
        }
    }

    void DirectionCheck(){
        if(enemyMove > 0.01){
            facingRight = true;
        } else if(enemyMove < -0.01){
            facingRight = false;
        }

        animator.SetBool("Facing_Right", facingRight);
    }
}
