using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public bool facingRight = true;
    public bool bag = false;
    public float speed = 40f;
    
    // Start is called before the first frame update
    void Start()
    {
        facingRight = true;
        bag = false;
    }

    // Update is called once per frame
    void Update()
    {
        float moveInput = Input.GetAxis("Horizontal");
        float playerMove = moveInput  * speed * Time.deltaTime;
        transform.Translate(new Vector3(playerMove, 0, 0))
    }
}
