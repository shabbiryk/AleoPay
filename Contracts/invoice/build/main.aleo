program invoice.aleo;

struct UserDigitalName:
    lens_id as field;
    twitter as field;
    telegram as field;
    gitcoin_passport_id as field;
    zkcat as field;

struct UserAddress:
    owner_key as address;


mapping key_to_userID:
	key as address.public;
	value as UserDigitalName.public;

function add_digital_ids:
    input r0 as UserDigitalName.private;
    cast self.caller into r1 as UserAddress;
    async add_digital_ids self.caller r0 into r2;
    output r1 as UserAddress.private;
    output r2 as invoice.aleo/add_digital_ids.future;

finalize add_digital_ids:
    input r0 as address.public;
    input r1 as UserDigitalName.public;
    set r1 into key_to_userID[r0];


function update_digital_ids:
    input r0 as UserDigitalName.private;
    cast self.caller into r1 as UserAddress;
    async update_digital_ids self.caller r0 into r2;
    output r1 as UserAddress.private;
    output r2 as invoice.aleo/update_digital_ids.future;

finalize update_digital_ids:
    input r0 as address.public;
    input r1 as UserDigitalName.public;
    cast 0field 0field 0field 0field 0field into r2 as UserDigitalName;
    get.or_use key_to_userID[r0] r2 into r3;
    assert.neq r3.lens_id 0field;
    set r1 into key_to_userID[r0];


function get_digital_ids_hash:
    input r0 as UserDigitalName.private;
    hash.bhp256 r0.lens_id into r1 as field;
    hash.bhp256 r0.twitter into r2 as field;
    hash.bhp256 r0.telegram into r3 as field;
    hash.bhp256 r0.gitcoin_passport_id into r4 as field;
    hash.bhp256 r0.zkcat into r5 as field;
    cast r1 r2 r3 r4 r5 into r6 as UserDigitalName;
    async get_digital_ids_hash self.caller r6 into r7;
    output r6 as UserDigitalName.private;
    output r7 as invoice.aleo/get_digital_ids_hash.future;

finalize get_digital_ids_hash:
    input r0 as address.public;
    input r1 as UserDigitalName.public;
    cast 0field 0field 0field 0field 0field into r2 as UserDigitalName;
    get.or_use key_to_userID[r0] r2 into r3;
    assert.neq r3.lens_id 0field;
    hash.bhp256 r3.lens_id into r4 as field;
    hash.bhp256 r3.twitter into r5 as field;
    hash.bhp256 r3.telegram into r6 as field;
    hash.bhp256 r3.gitcoin_passport_id into r7 as field;
    hash.bhp256 r3.zkcat into r8 as field;
    cast r4 r5 r6 r7 r8 into r9 as UserDigitalName;
    assert.eq r1 r9;
