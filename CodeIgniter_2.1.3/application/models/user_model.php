<?php

class Player_model extends CI_Model {

    var $title   = '';
    var $content = '';
    var $date    = '';

    function __construct() {

        parent::__construct();

    }

    function read() {

        $query = $this->db->get_where('users', array('id' => $id));
        return $query->result();

    }

    function insert() {

        $this->title   = $_POST['title']; // please read the below note
        $this->content = $_POST['content'];
        $this->date    = time();

        $this->db->insert('entries', $this);

    }

    function update() {

        $this->title   = $_POST['title'];
        $this->content = $_POST['content'];
        $this->date    = time();

        $this->db->update('entries', $this, array('id' => $_POST['id']));

    }

}

?>