# Collective calls

function Allreduce!(sendbuf, recvbuf, count::Integer, op, comm::Communicator; stream::CuStream=CuDefaultStream() )
    data_type = ncclDataType(eltype(recvbuf))
    @apicall(:ncclAllReduce, (CuPtr{Cvoid}, CuPtr{Cvoid}, Cint, ncclDataType_t, ncclRedOp_t, ncclComm_t, CUstream),
             sendbuf, recvbuf, count, data_type, op, comm.handle, stream)
    return recvbuf
end

function Broadcast!(sendbuf, recvbuf, count::Integer, root::Int, comm::Communicator; stream::CuStream=CuDefaultStream() )
    data_type = ncclDataType(eltype(recvbuf))
    @apicall(:ncclBroadcast, (CuPtr{Cvoid}, CuPtr{Cvoid}, Cint, ncclDataType_t, Cint, ncclComm_t, CUstream),
             sendbuf, recvbuf, count, data_type, root, comm.handle, stream)
    return recvbuf
end