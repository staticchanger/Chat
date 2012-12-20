<?php

class User extends CI_Controller {

    function __construct() {

        parent::__construct();

        $this->load->model('User_model');

        // Name of table containing users.
        $this->tbl_user = 'user';

    }

    function index() {

        $method = $_SERVER['REQUEST_METHOD'];

        if( $method === 'GET' ) $this->User_model->get_users();

        else if( $method === 'POST' ) $this->User_model->add_user();

        else echo $this->_response( 405, "Error: That HTTP method is not supported for this URL.");

    }

    function index_with_id( $id ) {

        $method = $_SERVER['REQUEST_METHOD'];

        if( $method === 'GET' ) $this->User_model->get_user( $id );

        else if( $method === 'POST' ) $this->_update_user( $id );

        else if( $method === 'DELETE' ) $this->_delete_user( $id );

        else echo $this->_response( 405, "Error: That HTTP method is not supported for this URL.");

    }

    // Update a user.
    private function _update_user( $id ) {

        // Check that user exists.
        if( $this->User_model->does_exist( $id, $this->tbl_user ) ) {

            $this->load->library('form_validation');

            // Does POST data pass validation?
            if( $this->form_validation->run('update_user') ) {

                // Returns all POST items with XSS filter.
                $data = $this->input->post(NULL, TRUE);

                // Is an attempt being made to change the user ID?
                if( array_key_exists( 'id', $data ) ) {

                    echo $this->_response( 403, "Error: Changing a user's ID is forbidden." );

                } else  {

                    $column_chk_result = $this->_columns_exist( $data, $this->tbl_user );

                    // Do columns exist for all submitted values?
                    if( $column_chk_result === TRUE ) {

                       $this->User_model->update( $id, $data, $this->tbl_user );

                       echo $this->_response( 200, "Success: User updated." );

                    } else {

                        // A column was supplied that does not exist.
                        echo $this->_response( 500, "Error: No such column $column_chk_result" );

                    }

                }

            }  else {

                // Form validation failed.
                echo $this->_response( 400, validation_errors() );

            }

        } else {

            echo $this->_response( 404, "Error: No such user exists." );

        }

    }

    // Delete a user.
    private function _delete_user( $id ) {

        // Check that user exists.
        if( $this->User_model->does_exist( $id, $this->tbl_user ) ) {

            // Delete user.
            $this->User_model->delete( $id, $this->tbl_user );

            echo $this->_response( 200, "Success: User was removed." );

        } else {

            echo $this->_response( 500, "Error: No such user exists." );

        }

    }

    // Sets HTTP headers and generates a JSON response
    // which can be used for output.
    private function _response( $code, $message, $data = NULL, $location = '' ) {

        if( $code == 201 ) {

            // Special case requires URL of newly created resource.

            $this->output->set_header("HTTP/1.1 201 Created");

            $this->output->set_header("Location: $location");

        } else {

            $this->output->set_status_header( $code );

        }

        // If no data is supplied, leave the field out.
        if( !isset( $data ) ) $response = array( 'code' => $code, 'message' => $message );

        // But if data is supplied, then add it.
        else $response = array( 'code' => $code, 'message' => $message, 'data' => $data );

        $this->output->set_content_type('application/json');

        $json = json_encode( $response );

        return $json;

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

/* End of file user.php */
/* Location: ./application/controllers/user.php */