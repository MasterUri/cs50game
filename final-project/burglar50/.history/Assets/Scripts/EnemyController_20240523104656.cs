using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class EnemyController : MonoBehaviour
{
    public bool facingRight = true;
    public float speed = 3f;
    public bool alert = false;
    
    private float enemyMove;

    public EnemyController[] cops;
    public CopDetector[] copDetectors;
    public GameObject detectionRight;
    public GameObject detectionLeft;
    private CopDetector detectorRight;
    private CopDetector detectorLeft;
    public Transform waypoint1;
    public Transform waypoint2;
    public Transform player = null;
    public Animator animator;

    private AudioSource audioSource;
    

    // Start is called before the first frame update
    void Start()
    {
        detectorLeft = detectionLeft.GetComponent<CopDetector>();
        detectorRight = detectionRight.GetComponent<CopDetector>();
        audioSource = gameObject.GetComponent<AudioSource>();
        copDetectors = GameObject.FindObjectsOfType<CopDetector>();
        cops = GameObject.FindObjectsOfType<EnemyController>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if ((detectorLeft.detected == true || detectorRight.detected == true) && alert == false) {
            if (alert == false) {
                audioSource.Play();
            }
            animator.SetBool("Alert", true);
            speed = speed * 3;
            for (int i = 0; i < cops.Length; i++){
                if (copDetectors[i].detected == false) {
                    copDetectors[i].detected = true;
                }
                cops[i].detectionLeft.SetActive(false);
                cops[i].detectionRight.SetActive(false);
            }
            alert = true;
        }

        enemyMove = speed * Time.deltaTime;
        animator.SetFloat("Speed", enemyMove);
        transform.Translate(new Vector3(enemyMove, 0, 0));
    }

    private void Update() {
        DirectionCheck();
    }

    void DirectionCheck(){
        
        if (alert){
            if (gameObject.transform.position.x > player.position.x && facingRight){
                speed = -speed;
                facingRight = false;
            }
            else if (gameObject.transform.position.x < player.position.x && !facingRight){
                speed = Mathf.Abs(speed);
                facingRight = true;
            }
            detectionLeft.SetActive(false);
            detectionRight.SetActive(false);
        } else if (gameObject.transform.position.x > waypoint2.position.x ) {
            speed = -speed;
            detectionLeft.SetActive(true);
            detectionRight.SetActive(false);
            facingRight = false;
        } else if (gameObject.transform.position.x < waypoint1.position.x) {
            speed = Mathf.Abs(speed);
            detectionLeft.SetActive(false);
            detectionRight.SetActive(true);
            facingRight = true;
        }

        animator.SetBool("Facing_Right", facingRight);
    }

    private void OnTriggerEnter2D(Collider2D other) {
        if (alert) {
            if (other.gameObject.tag == "Player") {
                SceneManager.LoadScene("Loose");
            }
        }
        
    }
}
