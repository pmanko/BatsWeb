function pageLoad(sender, args) {
    var ctx = document.getElementById("myGoalChart");
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["Capitals", "Lightning",],
            //"Yellow", "Green", "Purple", "Orange"],
            datasets: [{
                label: 'Goals Scored',
                data: [12, 19, 3, 5, 2, 3],
                backgroundColor: [
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)'
                    //'rgba(255, 206, 86, 0.2)',
                    //'rgba(75, 192, 192, 0.2)',
                    //'rgba(153, 102, 255, 0.2)',
                    //'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)'
                    //'rgba(255, 206, 86, 1)',
                    //'rgba(75, 192, 192, 1)',
                    //'rgba(153, 102, 255, 1)',
                    //'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: false
                    }
                }],
                xAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: false
                    }
                }]
            },
            legend: {
                display: true, 
                labels: {
                    fontSize: 18, 
                    boxWidth : 0
                }
                
            },
            tooltips: {
                displayColors: false
            },
            annotation: {
                annotations: [
                    {
                        type: "line",
                        mode: "horizontal",
                        scaleID: "y-axis-0",
                        value: "10",
                        borderColor: "black",
                        borderDash: [2, 2],
                        borderDashOffset: 5
                        //label: {
                        //    content: "TODAY",
                        //    enabled: true,
                        //    position: "top"
                        //}
                    }
                ]
            }
        }
    });
    var ctx = document.getElementById("myChanceChart");
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["Capitals", "Lightning",],
            //"Yellow", "Green", "Purple", "Orange"],
            datasets: [{
                label: 'Chances',
                data: [32, 25, 3, 5, 2, 3],
                backgroundColor: [
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)'
                    //'rgba(255, 206, 86, 0.2)',
                    //'rgba(75, 192, 192, 0.2)',
                    //'rgba(153, 102, 255, 0.2)',
                    //'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)'
                    //'rgba(255, 206, 86, 1)',
                    //'rgba(75, 192, 192, 1)',
                    //'rgba(153, 102, 255, 1)',
                    //'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: true
                    }
                }],
                xAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: false
                    }
                }]
            },
            legend: {
                display: true,
                labels: {
                    fontSize: 18,
                    boxWidth: 0
                }

            },
            tooltips: {
                displayColors: false
            },
            annotation: {
                annotations: [
                    {
                        type: "line",
                        mode: "horizontal",
                        scaleID: "y-axis-0",
                        value: "17.5",
                        borderColor: "black",
                        borderDash: [2, 2],
                        borderDashOffset: 5
                        //label: {
                        //    content: "TODAY",
                        //    enabled: true,
                        //    position: "top"
                        //}
                    }
                ]
            }
        }
    });
    var ctx = document.getElementById("fwdGoalChart");
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [["A BURAKOVSKY-B", "CONNOLLY-L", "ELLER"], ["A CHIASSON-J", "BEAGLE-C", "STEPHENSON"], ["A OVECHKIN-T", "WILSON-N", "BACKSTROM"], ["E KUZNETSOV-A", "OVECHKIN-D", "SMITH-PELLY"],
                ["E KUZNETSOV-A", "OVECHKIN-D", "SMITH-PELLY"], ["J BEAGLE-D", "SMITH-PELLY-C", "STEPHENSON"], ["N BACKSTROM-A", "BURAKOVSKY-T", "OSHIE"], ["N BACKSTROM-A", "OVECHKIN-D", "SMITH-PELLY"]],
            datasets: [{
                label: 'Goals For',
                data: [1.4, 1.2, .8, 1.3, 1.7, .5, .3, 2.0],
                backgroundColor: [
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)'
                ],
                borderWidth: 1
            },  {
                label: 'Goals Against',
                data: [.7, 1.5, .6, .9, 1.8, 1.6, .5, 1.01],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            maintainAspectRatio: false,
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: false
                    }
                }],
                xAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: true
                    }
                }]
            },
            legend: {
                display: true,
                labels: {
                    fontSize: 18,
                  //  boxWidth: 0
                }

            },
            tooltips: {
                displayColors: false,
            },
            annotation: {
                annotations: [
                    {
                        type: "line",
                        mode: "horizontal",
                        scaleID: "y-axis-0",
                        value: "1",
                        borderColor: "black",
                        borderDash: [2, 2],
                        borderDashOffset: 5
                        //label: {
                        //    content: "TODAY",
                        //    enabled: true,
                        //    position: "top"
                        //}
                    }
                ]
            }
        }
    });
    var ctx = document.getElementById("fwdChanceChart");
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [["A BURAKOVSKY-B", "CONNOLLY-L", "ELLER"], ["A CHIASSON-J", "BEAGLE-C", "STEPHENSON"], ["A OVECHKIN-T", "WILSON-N", "BACKSTROM"], ["E KUZNETSOV-A", "OVECHKIN-D", "SMITH-PELLY"],
            ["E KUZNETSOV-A", "OVECHKIN-D", "SMITH-PELLY"], ["J BEAGLE-D", "SMITH-PELLY-C", "STEPHENSON"], ["N BACKSTROM-A", "BURAKOVSKY-T", "OSHIE"], ["N BACKSTROM-A", "OVECHKIN-D", "SMITH-PELLY"]],
            datasets: [{
                label: 'Chances For',
                data: [1.4, 1.2, .8, 1.3, 1.7, .5, .3, 2.0],
                backgroundColor: [
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)',
                    'rgba(252, 99, 132, 0.2)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)',
                    'rgba(255,99,132,1)'
                ],
                borderWidth: 1
            }, {
                label: 'Chances Against',
                data: [.7, 1.5, .6, .9, 1.8, 1.6, .5, 1.01],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(54, 162, 235, 0.2)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(54, 162, 235, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            maintainAspectRatio: false,
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: false
                    }
                }],
                xAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: true
                    }
                }]
            },
            legend: {
                display: true,
                labels: {
                    fontSize: 18,
                    //  boxWidth: 0
                }

            },
            tooltips: {
                displayColors: false,
            },
            annotation: {
                annotations: [
                    {
                        type: "line",
                        mode: "horizontal",
                        scaleID: "y-axis-0",
                        value: "1",
                        borderColor: "black",
                        borderDash: [2, 2],
                        borderDashOffset: 5
                        //label: {
                        //    content: "TODAY",
                        //    enabled: true,
                        //    position: "top"
                        //}
                    }
                ]
            }
        }
    });
}


$(document).ready(function () {
    //$('[data-toggle="tooltip"]').tooltip();   
    //var data = [4, 8, 15, 16, 23, 42];

    //var x = d3.scale.linear()
    //    .domain([0, d3.max(data)])
    //    .range([0, 420]);

    //d3.select(".chart")
    //    .selectAll("div")
    //    .data(data)
    //    .enter().append("div")
    //    .style("width", function (d) { return x(d) + "px"; })
    //    .text(function (d) { return d; });

    //$('#teamRed1').hover(
    //    function() {
    //        $(this).css("opacity", .5);
    //    },
    //    function() {
    //        $(this).css("opacity", 1);
    //    }
    //        //  function() { teamRedHover($('#teamRed1')); }
    //    );
});

//function teamRedHover(sender) {
//    console.log(sender);
//    //sender.backgroundColor = "#000cfc";
//    var el = document.getElementById('teamRed1');
//    el.style.opacity = .5;
//}

// Player Selection
$(document).on('change', "#MainContent_ddTeam", function (event) {
    makeServerRequest('change-team', $(this).val())
});

