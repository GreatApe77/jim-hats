package com.mateusnavarro77.jim_hats_web_api.domain.usecases;

import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.DomainException;

public interface Usecase<Input,Output> {
    Output execute(Input input) throws DomainException;
}
