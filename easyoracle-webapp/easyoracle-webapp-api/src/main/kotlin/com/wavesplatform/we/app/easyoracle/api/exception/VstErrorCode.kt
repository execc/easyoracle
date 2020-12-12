package com.wavesplatform.we.app.easyoracle.api.exception

enum class VstErrorCode(val value: Int) {
    EXTERNAL_SERVICE_CALL(8000),
    METHOD_ARGUMENT_NOT_VALID(8001),
    HTTP_MESSAGE_NOT_READABLE(8002),
    FORBIDDEN(8403),
    INTERNAL_SERVER_ERROR(8500),
    UNDEFINED_ERROR_(9099)
}
