package com.zj.handler.exception;


import com.zj.domain.ResponseResult;
import com.zj.enums.AppHttpCodeEnum;
import com.zj.exception.SystemException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;


@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({SystemException.class})
    public ResponseResult systemExceptionHandler(SystemException e) {
        log.error("发生异常！{0}", e);
        return ResponseResult.errorResult(e.getCode(), e.getMsg());
    }

    @ExceptionHandler({MethodArgumentNotValidException.class, BindException.class})
    public ResponseResult methodArgumentNotValidExceptionHandler(BindException e) {
        log.error("发生异常！{0}", e);
        String message = e.getBindingResult().getAllErrors().get(0).getDefaultMessage();
        return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_NOT_VALID, message);
    }

}
