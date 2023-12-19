// The 'hello' program.
program invoice.aleo {
    struct UserDigitalName{
        lens_id:field,
        twitter:field,
        telegram:field,
        gitcoin_passport_id:field,
        zkcat:field
    }

    struct UserAddress {
        owner_key:address
    
    }

    mapping key_to_userID: address => UserDigitalName;

    

    // Adding the User digital Names to the mapping of his address to digital Names
    transition add_digital_ids (private digital_object:UserDigitalName)-> UserAddress {
        return UserAddress{owner_key:self.caller} then finalize(self.caller,digital_object);
    
    }
    finalize add_digital_ids (owner:address,object_digital:UserDigitalName) {
       Mapping::set(key_to_userID, owner,object_digital);  
    }
    
    // Modify the User ditial Names already there. Error would occur if invalid address is given
    transition update_digital_ids (private digital_object:UserDigitalName) -> UserAddress{
        return UserAddress{owner_key:self.caller} then finalize(self.caller, digital_object);
    }
    finalize update_digital_ids (owner:address, object_digital:UserDigitalName) {
        let default_digital_object:UserDigitalName = UserDigitalName{
        lens_id:0field,
        twitter:0field,
        telegram:0field,
        gitcoin_passport_id:0field,
        zkcat:0field
        };
        let current_digital_object:UserDigitalName = Mapping::get_or_use(key_to_userID,owner ,default_digital_object);
        // Only already added people can only edit.
        assert_neq(current_digital_object.lens_id,0field);
        Mapping::set(key_to_userID,owner, object_digital);

    }

    transition get_digital_ids_hash (digital_object:UserDigitalName) -> UserDigitalName  {
        let hash_of_user_digital_name: UserDigitalName = UserDigitalName {
            lens_id: BHP256::hash_to_field(digital_object.lens_id),
            twitter: BHP256::hash_to_field(digital_object.twitter),
            telegram: BHP256::hash_to_field(digital_object.telegram),
            gitcoin_passport_id: BHP256::hash_to_field(digital_object.gitcoin_passport_id),
            zkcat: BHP256::hash_to_field(digital_object.zkcat)

        }; 
        return hash_of_user_digital_name then finalize(self.caller, hash_of_user_digital_name);
    }
    finalize get_digital_ids_hash (owner:address, hash_digital_name:UserDigitalName) {
        let default_digital_object:UserDigitalName = UserDigitalName{
            lens_id:0field,
            twitter:0field,
            telegram:0field,
            gitcoin_passport_id:0field,
            zkcat:0field
        };
        let current_digital_object:UserDigitalName = Mapping::get_or_use(key_to_userID,owner ,default_digital_object);

        assert_neq(current_digital_object.lens_id,0field);
        let hash_of_user_digital_name: UserDigitalName = UserDigitalName {
            lens_id: BHP256::hash_to_field(current_digital_object.lens_id),
            twitter: BHP256::hash_to_field(current_digital_object.twitter),
            telegram: BHP256::hash_to_field(current_digital_object.telegram),
            gitcoin_passport_id: BHP256::hash_to_field(current_digital_object.gitcoin_passport_id),
            zkcat: BHP256::hash_to_field(current_digital_object.zkcat)
        };
        assert_eq(hash_digital_name, hash_of_user_digital_name);
    } 
    
}