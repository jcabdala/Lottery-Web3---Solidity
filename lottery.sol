 // SPDX-License-Identifier: MIT
pragma solidity <= 0.86;


contract lottery {
    
    address public owner;
    address[] participants ;

    // Eventos 
    event lottery_done(bytes32);
    event user_registry(string);
    // Constructor 
    constructor () public {
        owner = msg.sender;
    }
    

        // Control de las funciones ejecutables por el profesor
    modifier OnlyOwner(address _address){
        // Requiere que la direccion introducido por parametro sea igual al owner del contrato
        require(_address == owner, "Only Owner!");
        _;
    }


        // Funcion para pedir una revision del examen
    function RegisterInLottery(address _address) public {
        // Almacenamiento de la identidad del alumno en un array
        participants.push(_address);
        // Emision del evento 
        emit user_registry("User successfully registered");
    }
    
    // Funcion para ver los alumnos que han solicitado revision de examen
    function CheckParticipants() public view OnlyOwner(msg.sender) returns (address[]){
        // Devolver las identidades de los alumnos
        return participants;
    }
    
}
