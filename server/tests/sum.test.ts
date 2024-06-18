import {describe,expect,it} from "vitest" 

function sum(a:number,b:number){
    return a+b
}


it("Should sum",()=>{
    expect(sum(3,4)).to.be.equal(7)
})




