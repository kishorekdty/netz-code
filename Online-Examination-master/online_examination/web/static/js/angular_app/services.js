'use strict';

/* Services */

// Demonstrate how to register services
// In this case it is a simple value service.
var CampusERP_serv = angular.module('CampusERP.services', ['ngResource']);

CampusERP_serv.value('version', '0.1');

CampusERP_serv.factory('share', function()
{
    return {
        messages : {
            show : false,
            type : '',
            message : ''
        },
        loader : {
            show : false
        }
    };
});
