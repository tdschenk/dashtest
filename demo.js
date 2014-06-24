// ocpu.seturl("http://107.170.188.61/ocpu/github/erikriverson/pilrdash/R");

// ocpu.rpc("pilr_dashboard_panel", 
//          { "FUN" : "vistest",
//            "package" : "dashtest",
//            "package_location" : "github",
//            "pilr_server" : "qa.pilrhealth.com", 
//            "access_code" : "4efe6ea3-a2e5-41bc-964e-63ebf09ae851",
//            "data" : {"data_set" : "pilrhealth:location_ref_app:location",
//                      "schema" : "1"},
//            "github_info" : {"username" : "tdschenk", 
//                             "repository" : "dashtest", 
//                             "branch" : "master"},
//            "project" : "a-eiverson-project", 
//            "return_type" : "vega"
//          }, 
//          function(output) {
//              console.log(JSON.parse(output));
//              ggvis.getPlot("ggvis_univariate").parseSpec(JSON.parse(output));
//          });


 var DropdownCtrl = function($scope) {
  $scope.items = [
    'The first choice!',
    'And another choice for you.',
    'but wait! A third!'
  ];

  $scope.status = {
    isopen: true
  };

  $scope.toggled = function(open) {
    console.log('Dropdown is now: ', open);
  };

  $scope.toggleDropdown = function($event) {
    $event.preventDefault();
    $event.stopPropagation();
    $scope.status.isopen = !$scope.status.isopen;
  };
};
