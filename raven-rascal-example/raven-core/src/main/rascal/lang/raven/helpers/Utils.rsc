module lang::raven::helpers::Utils 

import Set;
import util::Math;

list[str] convertSetToList(set[int] inputSet) {
    list[str] resultList = [];
    
    for (int element <- inputSet) {
        resultList += util::Math::toString(element);
    }
    
    return resultList;
}
