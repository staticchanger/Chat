<?php

class User_model extends CI_Model {

    function __construct() {

        parent::__construct();

        // Name of table containing users.
        $this->table = 'user';

        $this->update_rules = array(

            array(

                'field' => 'username',

                'label' => "username",

                'rules' => 'is_unique[user.username]|min_length[3]|max_length[12]'

            ),

            array(

                'field' => 'x',

                'label' => 'X coordinate',

                'rules' => 'integer|divides_by[16]'

            ),

            array(

                'field' => 'y',

                'label' => 'Y coordinate',

                'rules' => 'integer|divides_by[16]'

            ),

            array(

                'field' => 'direction',

                'label' => 'direction faced',

                'rules' => 'is_direction'

            ),

            array(

                'field' => 'skin',

                'label' => 'skin',

                'rules' => 'alpha'

            ),

            array(

                'field' => 'state',

                'label' => 'movement state',

                'rules' => 'alpha'

            ),

            array(

                'field' => 'zone',

                'label' => 'current zone',

                'rules' => 'alpha'

            )

        );

        $this->add_rules = $this->update_rules;

        $this->add_rules[0]['rules'] .= '|required';

    }

    // Returns TRUE if a user with that ID exists.
    // Else returns FALSE.
    private function user_exists( $id, $table ) {

        $query = $this->db->get_where( $table, array('id' => $id) );

        return $query->num_rows() > 0;

    }

    // Respond with a single user.
    public function get_user( $id ) {

        if( $this->user_exists( $id, $this->table ) ) {

            $query = $this->db->get_where( $this->table, array('id' => $id) );

            // Take the first of the array.
            $data = array_shift( $query->result() );

            $code = 200;

            $message = 'Showing one user.';

            return array( "code" => $code, "message" => $message, "data" => $data );

        } else {

            $code = 404;

            $message = "No such user exists.";

        }

        return array( "code" => $code, "message" => $message );

    }

    // Respond with a list of users.
    public function get_users( $criteria ) {

        $limit = 10;

        $offset = 0;

        if( isset( $criteria[ 'limit' ] ) ) {

            $limit = $criteria[ 'limit' ];

            unset( $criteria[ 'limit' ] );

        }

        if( isset( $criteria[ 'offset' ] ) ) {

            $offset = $criteria[ 'offset' ];

            unset( $criteria[ 'offset' ] );

        }

        // Make empty array if no values exist.
        if( !$criteria ) $criteria = array();

        $column_chk_result = $this->_columns_exist( $criteria, $this->table );

        if( $column_chk_result === TRUE ) {

            $query = $this->db->get_where( $this->table, $criteria, $limit, $offset );

            $data = $query->result();

            $code = 200;

            $message = 'Showing ' . count( $data ) . ' users.';

            $next_page = "?offset=" . ( $offset + $limit ) . "&limit=$limit";

            return array( "code" => $code, "message" => $message, "next_page" => $next_page, "data" => $data );

        } else {

            $code = 400;

            // Duplicate message.
            $message = "Invalid column specified: $column_chk_result";

        }

        return array( "code" => $code, "message" => $message );

    }

    // Add a new user.
    public function add_user() {

        if( ! isset( $_POST ) || count( $_POST ) === 0 ) {

            $code = 400;

            // Duplicate message.
            $message = "Expecting POST data but none was supplied.";

        } else {

            $this->load->library('form_validation');

            $this->form_validation->set_rules( $this->add_rules );

            if( $this->form_validation->run('add_user') === FALSE ) {

                $code = 400;

                // Duplicate message.
                $message = "Validation failure: " . validation_errors();

            } else {

                // Returns all POST data with XSS filter.
                $data = $this->input->post(NULL, TRUE);

                if( array_key_exists('id', $data) ) {

                    $code = 400;

                    $message = "You may not manually specify ID.";


                } else {

                    $column_chk_result = $this->_columns_exist( $data, $this->table );

                    if( $column_chk_result !== TRUE ) {

                        $code = 400;

                        // Duplicate message.
                        $message = "Invalid column specified: $column_chk_result";

                    } else {

                        // Add user to database.
                        $this->db->insert( $this->table, $data );

                        $user_id = $this->db->insert_id();

                        // Allows us to use base_url().
                        $this->load->helper('url');

                        $location = base_url() . $this->table . '/' . $user_id;

                        $code = 201;

                        $message = "Successfully added user.";

                        return array( "code" => $code, "message" => $message, "location" => $location );

                    }

                }

            }

        }

        return array( "code" => $code, "message" => $message );

    }

    // Update a user.
    public function update_user( $id ) {

        if( ! isset( $_POST ) || count( $_POST ) === 0 ) {

            $code = 400;

            // Duplicate message.
            $message = "Expecting POST data but none was supplied.";

        } else if( ! $this->user_exists( $id, $this->table ) ) {

            $code = 404;

            $message = "No such user exists.";

        } else {

            $this->load->library('form_validation');

            $this->form_validation->set_rules( $this->update_rules );

            // Does POST data pass validation?
            if( $this->form_validation->run('update_user') === FALSE ) {

                $code = 400;

                // Duplicate message.
                $message = "Validation failure: " . validation_errors();

            } else {

                // Returns all POST data with XSS filter.
                $data = $this->input->post(NULL, TRUE);

                // Is an attempt being made to change the user ID?
                if( array_key_exists( 'id', $data ) ) {

                    $code = 403;

                    $message = "Changing a user's ID is forbidden.";

                } else  {

                    $column_chk_result = $this->_columns_exist( $data, $this->table );

                    // Do columns exist for all submitted values?
                    if( $column_chk_result === TRUE ) {

                        $this->db->where( 'id', $id );

                        $this->db->update( $this->table, $data );

                        $code = 200;

                        $message = "User data was updated successfully.";

                    } else {

                        $code = 400;

                        // Duplicate message.
                        $message = "Invalid column specified: $column_chk_result";

                    }

                }

            }

        }

        return array( "code" => $code, "message" => $message );

    }

    // Delete a user.
    public function delete_user( $id ) {

        // Check that user exists.
        if( $this->User_model->user_exists( $id, $this->table ) ) {

            $this->db->delete( $this->table, array( 'id' => $id ) );

            $code = 200;

            $message = "Success: User was removed.";

        } else {

            $code = 404;

            $message = "Error: No such user exists.";

        }

        return array( "code" => $code, "message" => $message );

    }

    // Returns TRUE if the array of values supplied
    // each correspond to a column in the database table.
    // Else returns the value of the bad column.
    private function _columns_exist( $columns, $table ) {

        foreach( $columns as $key => $value ) {

            if( !$this->db->field_exists( $key, $table ) ) {

                return $key;

            }

        }

        return TRUE;

    }

}

/* End of file user_model.php */
/* Location: ./application/controllers/user_model.php */