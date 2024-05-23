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
    private CopDetector detectorRight;
    private CopDetector detectorLeft;
    public GameObject waypoint1;
    public GameObject waypoint2;
    public PlayerController playerController = null;
    public Animator animator;

    private AudioSource audioSource;
    

    // Start is called before the first frame update
    void Start()
    {
        detectorLeft = detectionLeft.GetComponent<CopDetector>();
        detectorRight = detectionRight.GetComponent<CopDetector>();
    }

    // Update is called once per frame
    void Update()
    {
        if (facingRight) {
            detectionLeft.SetActive(false);
            detectionRight.SetActive(true);
            speed = Mathf.Abs(speed);
        } else {
            detectionLeft.SetActive(true);
            detectionRight.SetActive(false);
            speed = -speed;
        }

        DirectionCheck();

        if (detectorLeft.detected || detectorRight.detected) {
            if (alert == false) {
                audioSource.Play();
            }
            alert = true;
            speed = 10f;
        }

        enemyMove = speed * Time.deltaTime;
        animator.SetFloat("Speed", enemyMove);
        transform.Translate(new Vector3(enemyMove, 0, 0));
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
