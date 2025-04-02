// #let font1 = "New Computer Modern"
// #let font2 = "New Computer Modern"
#let font1 = "Inter"
#let font2 = "Inter Display"

#set text(font: font1, size: 10pt)
#set par(justify: true)

#show heading: it => text(weight: "semibold", font: font2)[
	#pad(bottom: 6pt, it.body)
]
#show figure: it => pad(bottom: 0.5cm, it)

#import "@preview/wordometer:0.1.4": word-count, total-words
// #import "@preview/plotst:0.2.0": *
// #import "@preview/sigfig:0.1.0": round
#import "sigfig.typ": round
#show: word-count.with(exclude: (table, figure, align, heading))

#v(2cm)

#let scn = "123456789" // Scottish Candidate Number

#align(center, [
	#text(18pt, font: font2)[
		*Investigation of Young's Modulus and\ the Shear Modulus for various steels*
	]
	#v(0.5cm)
	Lewin J Kelly / #scn\
	Advanced Higher Physics project \
	For SQA submission, session 2024-25\

	#total-words words, 25 pages\
	#v(0.5cm)
])

#let g = 9.8

// Experiment 1

#let e1_c = (0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 3, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4)
#let e1_r1 = (144, 147, 150, 154, 157, 159, 162, 166, 169, 174, 176, 179, 182, 185, 189, 191, 195, 198, 202, 205, 206, 208, 212, 217, 220, 224, 227, 230, 234, 236, 239, 242, 245, 248, 251, 255, 257, 261, 264, 266, 270)
#let e1_r2 = (143, 148, 151, 155, 157, 160, 164, 167, 170, 173, 174, 180, 183, 186, 188, 191, 195, 197, 203, 204, 206, 211, 213, 218, 222, 225, 229, 231, 234, 237, 240, 243, 246, 248, 250, 254, 258, 262, 264, 267, 270)
#let e1_r3 = (145, 148, 151, 154, 158, 159, 165, 167, 170, 174, 176, 180, 183, 186, 188, 192, 196, 199, 203, 205, 207, 210, 216, 218, 221, 224, 226, 230, 235, 236, 239, 243, 245, 248, 249, 255, 258, 261, 263, 266, 270)
#let e1_firstmean = (e1_r1.at(0) + e1_r2.at(0) + e1_r3.at(0)) / 3
#let e1_means = e1_r1.zip(e1_r2, e1_r3).map(r => (r.at(0) + r.at(1) + r.at(2)) / 3 - e1_firstmean)
#let e1_rmus = e1_r1.zip(e1_r2, e1_r3).map(r => (calc.max(r.at(0), r.at(1), r.at(2)) - calc.min(r.at(0), r.at(1), r.at(2))) / 3)

#let e1_meanmean = e1_means.sum() / e1_means.len()
#let meanrmu = e1_rmus.sum() / e1_rmus.len()

#let e1_n = e1_c.len()
#let e1_L = 0.9
#let (e1_wmm, e1_hmm) = (20, 6)
#let (e1_wm, e1_hm) = (e1_wmm / 1000, e1_hmm / 1000)

#let e1_x = e1_c.sum()
#let e1_y = e1_means.sum()
#let e1_xy = e1_c.zip(e1_means).map(i => i.at(0) * i.at(1)).sum()
#let e1_x2 = e1_c.map(i => calc.pow(i, 2)).sum()
#let e1_x_2 = calc.pow(e1_x, 2)

#let e1_d_m = (e1_n * e1_xy - e1_x * e1_y) / (e1_n * e1_x2 - e1_x_2) / 1000
#let e1_f_d = g / e1_d_m

#let e1_I = e1_wm * calc.pow(e1_hm, 3) / 12

#let e1_E = e1_f_d * calc.pow(e1_L, 3) / (3 * e1_I)

#let e1_gradientUncertainty = meanrmu / 0.5 / 1000
#let e1_DL_L = 0.0005 / e1_L
#let e1_DI_I = 0.0005 / e1_wm + 3 * 0.0005 / e1_hm
#let e1_Dd_d = meanrmu / e1_meanmean
#let e1_fake_DE_E = 3 * e1_DL_L + e1_DI_I + e1_Dd_d
#let e1_DE_E = e1_DI_I

// Experiment 2

#let e2_c = (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6)
#let e2_r1 = (600, 602, 603, 604, 605, 607, 608, 609, 609, 611, 612, 614, 614)
#let e2_r2 = (599, 601, 603, 605, 606, 607, 608, 608, 610, 611, 612, 613, 615)
#let e2_r3 = (600, 602, 603, 604, 605, 606, 608, 609, 611, 611, 613, 613, 614)
#let e2_firstmean = (e2_r1.at(0) + e2_r2.at(0) + e2_r3.at(0)) / 3
#let e2_means = e2_r1.zip(e2_r2, e2_r3).map(r => (r.at(0) + r.at(1) + r.at(2)) / 3 - e2_firstmean)
#let e2_rmus = e2_r1.zip(e2_r2, e2_r3).map(r => (calc.max(r.at(0), r.at(1), r.at(2)) - calc.min(r.at(0), r.at(1), r.at(2))) / 3)

#let e2_meanmean = e2_means.sum() / e2_means.len()
#let e2_meanrmu = e2_rmus.sum() / e2_rmus.len()

#let e2_wmms = (20.5, 20.4, 20.6, 20.4, 20.3)
#let e2_hmms = (6.2, 6.0, 6.1, 6.1, 6.3)
#let e2_ntimes = e2_wmms.len()

#let e2_n = e2_c.len()
#let e2_L = 0.96
#let (e2_wmm, e2_hmm) = (e2_wmms.sum() / e2_ntimes, e2_hmms.sum() / e2_ntimes)
#let (e2_wm, e2_hm) = (e2_wmm / 1000, e2_hmm / 1000)

#let e2_x = e2_c.sum()
#let e2_y = e2_means.sum()
#let e2_xy = e2_c.zip(e2_means).map(i => i.at(0) * i.at(1)).sum()
#let e2_x2 = e2_c.map(i => calc.pow(i, 2)).sum()
#let e2_x_2 = calc.pow(e2_x, 2)

#let e2_d_m = (e2_n * e2_xy - e2_x * e2_y) / (e2_n * e2_x2 - e2_x_2) / 1000
#let e2_f_d = g / e2_d_m

#let e2_I = e2_wm * calc.pow(e2_hm, 3) / 12

#let e2_E = e2_f_d * calc.pow(e2_L, 3) / (48 * e2_I)

#let e2_gradientUncertainty = e2_meanrmu / 0.5 / 1000
#let e2_DL_L = 0.0005 / e2_L
#let e2_DI_I = 0.0001 / e2_wm + 3 * 0.0001 / e2_hm
#let e2_Dd_d = e2_meanrmu / e2_meanmean
#let e2_fake_DE_E = 3 * e2_DL_L + e2_DI_I + e2_Dd_d
#let e2_DE_E = e2_DI_I + e2_Dd_d

// Experiment 3

#let e3_samples = (5.776, 6.113, 6.132, 5.987, 5.873, 5.999, 6.167)
#let e3_d = e3_samples.sum() / e3_samples.len()
#let e3_L = 0.1
#let e3_J = calc.pi * calc.pow(e3_d / 1000, 4) / 32

#let e3_angles = (
	(17.4, 18.6, 18.8, 19.8, 20.0, 21.2, 22.2, 23.6, 25.0, 29.0, 30.0, 30.0, 38.2, 74.2, 74.8, 76.0, 78.6, 79.0, 326.2, 327.0, 561.4, 562.6, 564.4, 565.6, 566.2, 566.6, 567.0, 567.6, 568.0, 568.2, 568.6, 569.0, 569.4, 569.8, 570.6, 571.0, 571.4, 572.2, 572.6, 573.2, 573.6, 574.2, 600.0),
	(6.0, 7.0, 7.4, 8.0, 8.4, 9.4, 10.0, 10.4, 11.2, 11.4, 12.2, 12.4, 12.4, 12.6, 12.8, 13.6, 14.0, 14.8, 15.8, 16.8, 17.4, 17.6, 18.8, 21.2, 25.8, 78.6, 78.8, 80.4, 81.8, 82.8, 121.0, 122.0, 139.4, 140.0, 151.0, 151.8, 169.8, 171.0, 171.2, 172.0, 172.4, 180.2, 183.2, 184.6, 185.4, 186.0, 186.2, 186.4, 186.6, 187.0, 187.2, 187.4, 187.6, 187.8, 188.0, 188.2, 188.2, 192.0).map(i => i + 2),
	(4.8, 6.2, 6.6, 7.2, 7.6, 8.2, 8.6, 9.0, 10.0, 10.0, 10.6, 11.0, 11.6, 12.2, 12.6, 13.2, 13.6, 14.0, 14.8, 16.2, 16.8, 18.2, 20.4, 24.8, 26.2, 26.4, 39.2, 53.6, 54.0, 451.6, 453.2, 454.4, 455.4, 456.0, 456.6, 456.8, 457.2, 457.6, 457.6, 458.0, 458.2, 458.4, 458.8, 459.0, 459.2, 459.6, 459.8, 460.0, 460.2, 460.4, 475.6),
	(2.4, 3.6, 3.6, 5.0, 5.0, 6.2, 6.2, 6.2, 7.4, 7.4, 7.6, 8.4, 8.6, 8.8, 9.4, 10.0, 10.0, 10.6, 11.2, 11.2, 12.4, 12.4, 13.6, 14.8, 16.2, 18.8, 22.8, 35.0, 36.2, 37.2, 44.8, 45.0, 66.2, 66.2, 66.4, 67.4, 76.0, 76.2, 83.6, 83.8, 84.8, 85.6, 89.8, 90.2, 94.8, 95.4, 318.2, 318.8, 323.8, 324.2, 324.8, 324.8, 325.4, 326.8, 328.0, 334.6, 336.0, 337.0, 338.0, 339.2, 340.6, 341.2, 341.6, 341.8, 341.8, 342.0, 342.2, 342.4, 342.8, 343.0, 343.2, 343.4).map(i => i + 4),
	(2.5, 3.4, 4.8, 5.8, 6.6, 7.4, 8.0, 8.6, 9.4, 10.2, 10.6, 11.4, 11.8, 12.6, 13.0, 13.8, 14.6, 15.4, 16.8, 19.2, 24.2, 36.0, 81.6, 119.8, 120.4, 160.2, 161.0, 170.8, 173.4, 175.2, 175.4, 177.4, 184.0, 185.6, 187.4, 189.0, 190.6, 191.6, 192.2, 192.4, 192.8, 193.0, 193.2, 193.4, 193.6, 194.0, 194.2, 194.4, 194.6, 212.0).map(i => i + 4),
)
#let e3_torques = (
	// graphs are upside down
	(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 5, 4, 3, 2, 3, 2, 3, 2, 3, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24).map(j => 26 - j),
	(22, 20, 19, 18, 17, 16, 15, 13, 12, 11, 10, 9, 8, 9, 8, 7, 6, 5, 4, 3, 4, 3, 2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2, 3, 4, 6, 8, 11, 13, 15, 17, 19, 21, 23, 25, 26, 25, 25).map(j => 26 - j),
	(24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 2, 1, 0, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 18, 20, 21, 22, 23, 24, 25, 25).map(j => 26 - j),
	(21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 5, 6, 5, 6, 5, 4, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 5, 4, 3, 2, 1, 0, 1, 2, 4, 7, 9, 12, 14, 16, 19, 21, 23, 24).map(j => 24 - j),
	(22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 14, 16, 17, 19, 20, 21, 22, 22).map(j => 26 - j)
)

#let len = 10
#let e3_firstangles = e3_angles.map(i => i.slice(0, len))
#let e3_firsttorques = e3_torques.map(i => i.slice(0, len))
#let e3_taus = e3_firsttorques.map(i => i.sum() / i.len())
#let e3_tau = e3_taus.sum() / e3_taus.len()
#let e3_thetas = e3_firstangles.map(i => i.sum() / i.len())
#let e3_theta = e3_thetas.sum() / e3_thetas.len()

#let rad = t => t * calc.pi / 180

#let e3_Gs = (
	e3_firstangles.zip(e3_firsttorques)
		.map(
			i => i.at(0).zip(i.at(1))
				.map(
					j => {
						let theta = j.at(0)
						let tau = j.at(1)

						(tau * e3_L) / (e3_J * rad(theta))
					}
				)
		)
)
#let e3_meanGs = e3_Gs.map(i => i.sum() / i.len())
#let e3_G = e3_meanGs.sum() / e3_meanGs.len()
#let e3_RMUs = e3_Gs.map(i => (calc.max(..i) - calc.min(..i)) / len)
#let e3_meanRMU = e3_RMUs.sum() / e3_RMUs.len()

#let e3_longest = calc.max(..e3_torques.map(i => i.len()))

#let e3_Dd_d = 0.001 / e3_d // mm (calipers)
#let e3_DL_L = 0.001 / e3_L // m (ruler)
#let e3_DJ_J = 4 * e3_Dd_d
#let e3_Dtau_tau = 1 / e3_tau
#let e3_Dtheta_theta = 0.2 / e3_theta
#let e3_fake_DG_G = e3_Dtau_tau + e3_Dtheta_theta + e3_DL_L + e3_DJ_J
#let e3_DG_G = e3_Dtau_tau

//

#pad(1.8cm, [
	*Abstract.* This report aimed to investigate the value of the flexural modulus (equivalent to Young's Modulus for the values in the experiments used) or Shear Modulus for certain types of steel in a variety of situations. 3 Advanced Higher-level experiments were carried out.

	#h(0.5cm)

	Experiment 1 used a steel bar with one end attached to a desk and a force applied to the extreme end with varying sets of masses. This resulted in a calculated value of Young's Modulus $E = #round(e1_E / 1e9, 3)$GPa, with an uncertainty of $plus.minus#round(e1_DE_E * e1_E / 1e9, 3)$GPa ($#round(e1_E, 3)$ $plus.minus#round(e1_DE_E * e1_E, 3)$Nm#super[-2]).

	Experiment 2 used the same steel bar supported on both ends with the force applied with weights in the centre of the bar. The value of Young's Modulus from this experiment was found to be $#round(e2_E / 1e9, 3)$GPa $plus.minus#round(e2_DE_E * e1_E / 1e9, 3)$GPa ($#round(e2_E, 3)$ $plus.minus#round(e2_DE_E * e2_E, 3)$Nm#super[-2]).

	Experiment 3 used steel rods held stationary at one end and with the other rotated by a torsion testing machine. The value for the Shear Modulus $G$ was found as $#round(e3_G / 1e9, 3)$GPa, with uncertainty $plus.minus#round(e3_DG_G * e3_G /1e9, 3)$GPa ($#round(e3_G, 3)$ $plus.minus#round(e3_DG_G * e3_G, 3)$Nm#super[-2]).

	#h(0.5cm)

	Values from experiments 1 and 2 were found to be close to real-world values for steel of approximately 200GPa (#round(200e9, 3)Nm#super[-2]) @etoolbox @civilsguide, showing that the methods used were valid and reliable.

	The value from experiment 3 was much lower than the expected value of #(sym.tilde)76GPa (#round(76e9, 2)Nm#super[-2]) @eedge, which may be due to the rods being of different grade steel than the bar used in experiments 1 and 2, or more likely that the method used was less reliable than that used in the other experiments.
])

#pagebreak()
#set page(
	margin: 1cm,

	footer: context [
		#set align(center)
		#set text(8pt)
		#counter(page).display("1 / 1", both: true)
		#h(1cm)
		#scn
	]
)

#show outline.entry.where(level: 1): set block(above: 0.75cm)
#outline(indent: 0.5cm)
#pagebreak()

= Underlying Physics

Young's Modulus ($E$) is defined as $sigma/epsilon$, where $sigma$ is the apparent stress (force per unit area) and $epsilon$ is the strain (proportional deformation against a reference point). The Shear Modulus ($G$) is defined similarly as $tau/gamma$, where $tau$ is shear stress and $gamma$ is shear strain. Both are commonly shown on graphs of stress against strain (stress-strain curve), where the modulus is the gradient of the initial linear portion of the graph, meaning stress is proportional to strain. This occurs from the origin of the stress-strain curve up until the yield point, where deformation becomes plastic instead of elastic, meaning the sample will no longer return to its original shape when the force is removed.

The moduli are quantitative measures of a material sample’s ability to withstand length or shape changes under applied force, known as its stiffness. Stress (axial stress for Young's Modulus, and shear stress for the Shear Modulus) has units of force per area, being defined by $sigma = F/A$, and is commonly measured in Newtons per metre squared (Nm#super[-2]), equal to Pascals (Pa), whereas strain has units of metres per metre, being defined by $epsilon = (Delta L)/L$ (change in length over original length), and is therefore dimensionless. Stress is commonly displayed in units of Gigapascals (GPa), and stiffness quantities can be heavily affected by the shape or geometry of the material.

#figure(
	image("nicoguaro.svg", width: 70%),
	caption: [Graph of a stress-strain curve for a ductile material such as steel @nicoguaro.],
)

If strain increses after the yield point, the stress may decrease to a lower yield point before continuing to increase until the ultimate strength, where stress is highest. After this point, necking or other disproportionate strain will result in uneven local deformation of the material, and the stress will decrease until a fracture or breakage occurs.
For any stress-strain curve, the area under the curve from zero strain until fracture is equal to the energy absorbed from the force applied to the sample. This is known as the material’s toughness. These quantities can also be measured with compression force rather than tension.

Hooke’s law states that the force needed to extend or compress a spring/other elastic sample (Hookean) is proportional to the distance the spring moves by. Materials undergoing elastic deformation abide by this law due to the proportionality between stress and strain defined by Young's Modulus.

#figure(
	image("wdjghalf.png", width: 70%),
	caption: [Hookean deformation with masses applying force to a spring @wdjghalf.],
)

For brittle materials like ceramics and glass, Young's Modulus and the Shear Modulus occur at most points on the stress-strain graph, as the sample will fracture before yield or ultimate strength points are able to be well-defined. For ductile materials like metals, it only occurs near the start of the graph, as the yield point is well-defined for when elastic deformation ends and plastic deformation begins.

Relationships between stress and strain are affected by many external factors which need to be normalised to prevent change in factors like temperature affecting final results or conclusions.

#pagebreak()

= Experiment 1

== Aim

The aim of experiment 1 was to find the Young's Modulus of a metal bar used as a cantilever, with a force applied to the extreme end of the cantilever using varying sets of masses.

== Underlying Physics

In this experiment, the independent variable was the force applied to the end of the cantilever $F$, and the dependent variable was the deflection of the end of the bar ($delta$). Force applied to the end of the bar was calculated with $F=m a$, using a value of $a =$ #(g)ms#super[-2] for Earth's gravitational field strength. For the small strains applied in this experiment, the flexural modulus of elasticity of the steel bar was equal to the Young's Modulus, which was calculated with the following equation (rearranged from @doitpoms):

$ E=(L^3F)/(3I delta) $

In this equation, $L$ is the usable length of the bar, $delta$ is the deflection of the end of the bar, and $F$ is the load force applied to the end of the bar. $I$ is the second moment of area of the cross-section of the steel bar, calculated with $I = (w h^3)/12$, where $w$ and $h$ are the width and height of the prismatic steel bar respectively, measured in metres. This gives $I$ a unit of m#super[4].

#figure(
	[#h(0.5cm)#image("doitpoms.gif", width: 70%)#h(0.5cm)],
	caption: [Diagram a generic cantilever setup, which this experiment was based on. Applied force, length, beam height, and deflection are shown as $P$, $L$, $h$, and $delta$ respectively @doitpoms.],
)

== Method

The steel bar was clamped to a worktop securely at one end. Masses were attached over the end of the bar using a piece of cord (with negligible mass) to ensure optimal force distribution, and depth $d$ of the end of the bar was observed and noted with a metrestick (scale reading uncertainty of $plus.minus$0.5mm) from the top edge of the bar. Deflection of the cantilever with a mass and weight of 0 was observed to be $#round(e1_firstmean, 4)$mm.

#figure(
	[#h(0.5cm)#image("diagram1.svg", width: 70%)#h(0.5cm)],
	caption: [Diagram of the cantilever setup used in this experiment.],
)

== Procedure

 2 G-clamps were used to secure the bar to a sturdy worktop, preventing it from moving. The bar was found to have a total length of just over 1m, of which #(e1_L)m was used in the experiment, with the excess clamped to the desk. Masses used ranged from 0 to 4kg, in increments of 0.1kg. 3 experimental readings were taken for each mass to improve reliability of the results. The width and height of the bar were measured to be $w = #e1_wmm$mm and $h  =  #e1_hmm$mm respectively.

== Results

=== Raw results and averages

#text(features: ("tnum",))[#table(
	columns: range(8).map(_ => auto),
	inset: (x: 10pt),

	table.header(
		table.cell(rowspan: 2)[*Mass* ($m$, kg)],
		table.cell(rowspan: 2)[*Load force* ($F$, N)],
		table.cell(colspan: 5)[*Depth Readings* ($d$, mm)],
		table.cell(rowspan: 2)[*Deflection* ($delta$, mm)],
		[1], [2], [3], [*Mean*], [*RMU*]
	),

	..for col in e1_c.zip(e1_r1, e1_r2, e1_r3) {
		let mass = col.at(0)
		let mean = (col.at(1) + col.at(2) + col.at(3)) / 3
		let rmu = (calc.max(col.at(1), col.at(2), col.at(3)) - calc.min(col.at(1), col.at(2), col.at(3))) / 3
		(
			[*#mass*],
			[#round(mass * g, 3)],
			[#col.at(1)],
			[#col.at(2)],
			[#col.at(3)],
			[#round(mean, 4)],
			[$plus.minus$ #round(rmu, 2)],
			[#round(mean - e1_firstmean, 4)],
		)
	}
)]

Each mean depth reading was calculated with $overline(d) = 1/3(d_1 + d_2 + d_3)$. RMUs (random mean uncertainties) were calculated as $1/3(max d  - min d)$.

=== Graphs

#figure(
	image("chart1.png", width: 70%),
	caption: [Graph of deflection of bar against mass applied for experiment 1, with best fit line in red.],
)

As the graph was found to be linear, the slope for its line of best fit was calculated with the following formula.

$ (n Sigma x y - Sigma x Sigma y)/(n Sigma x^2 - (Sigma x)^2) $

For this formula, $n$ is the number of data points (#e1_n), $x$ is the mass applied, and $y$ is the deflection of the bar. For the collected data:

$Sigma x = #e1_x$

$Sigma y = #calc.round(e1_y, digits: -1)$

$Sigma x y = #calc.round(e1_xy, digits: -1)$

$Sigma x^2 = #e1_x2$

$(Sigma x)^2 = #e1_x_2$

This results in a gradient of $delta/m = #round(e1_d_m * 1000, 3)$mmkg#super[-1], or $#round(e1_d_m, 3)$mkg#super[-1]. To get this in units of distance over force the gradient was divided by acceleration due to gravity $g$ ($#g$Nkg#super[-1]), resulting in $delta/(m g) = delta/F = #round(e1_d_m/g, 3)$mN#super[-1], and rearranging for $F/delta$ gives $#round(e1_f_d, 3)$Nm#super[-1].

#pagebreak()

=== Calculations

Solving the original Young's Modulus equation for this value gives the following equation.

$ F/delta = (3 E I)/L^3 $

The value for $I$ was found by subsituting $w$ and $h$ into this equation:

$ I = (w h^3)/12 = (#e1_wm times #e1_hm^3)/12 $

 This gives a value of $I = #round(e1_I, 3)$m#super[4]. Substituting all known parameters into the Young's Modulus equation, solving for $E$, and simplifying gives the following.

$
	#round(e1_f_d, 3) = (3E times #round(e1_I, 3))/(#e1_L^3)
	#h(0.5cm) therefore #h(0.5cm)
	#round(e1_f_d, 3) times #e1_L^3 = 3E times #round(e1_I, 3)
	#h(0.5cm) therefore #h(0.5cm)
	E = (#round(e1_f_d, 3) times #e1_L^3)/(3 times #round(e1_I, 3)) = #round(e1_f_d * calc.pow(e1_L, 3), 3)/#round(3 * e1_I, 3)
$

This gives a final value of $E = #round(e1_E, 3)$Nm#super[-2], approximately equal to $ #round(e1_E / 1e9, 3)$GPa.

=== Calculated Uncertainties

Scale reading uncertainties in length for width $w$, height $h$, length $L$, and bar deflection $delta$ were all $plus.minus$0.5mm. Calibration uncertainties in mass $m$ and load force $F$ were considered negligible ($(Delta F)/F = 0$), and calibration uncertainties for the measurement of lengths with metresticks ($w$, $h$, $L$, $delta$) could not be found, so also were estimated to be negligible. The random mean uncertainties in mass an be averaged to produce a mean RMU ($Delta m$), equal to $plus.minus#round(meanrmu, 3)$mm.

As the best fit line of the graph goes through the origin, there was no systematic uncertainty in the gradient of the line. The standard uncertainty in the gradient was calculated as $(Delta m)/(Delta delta)$, equalling $plus.minus#round(e1_gradientUncertainty * 1000, 3)$mmkg#super[-1], or $plus.minus#round(e1_gradientUncertainty, 3)$mkg#super[-1]. This was converted to a relative uncertainty by dividing by the gradient, giving a relative uncertainty of $plus.minus#round(e1_gradientUncertainty / e1_d_m * 100, 3)$%.

The uncertainty in the second moment of area $I$ was calculated with the following equation.

$ (Delta I)/I = (Delta w)/w + 3(Delta h)/h = 0.0005/#e1_wm + 3 times 0.0005/#e1_hm = #round(e1_DI_I, 3) $

This gives an uncertainty in $I$ equal to $plus.minus#round(e1_DI_I * e1_I, 3)$m#super[4], or relatively, $plus.minus#round(e1_DI_I * 100, 3)$%.

$(Delta delta)/(delta)$ was calculated by dividing the mean RMU by mean deflection #sym.dash $(#round(meanrmu, 3))/(#round(e1_meanmean, 3)) = plus.minus#round(e1_Dd_d, 3)$, giving a relative uncertainty of $plus.minus#round(e1_Dd_d * 100, 3)$%. To calculate $(Delta L)/L$,  the scale reading uncertainty in length was divided by the bar length, giving a relative uncertainty of $plus.minus#round(e1_DL_L * 100, 3)$%.

The total uncertainty in the Young's Modulus $E$ was calculated with the following equation, derived from the powers and coefficients used in the original equation.

$ (Delta E)/E = 3(Delta L)/L +  (Delta I)/I + (Delta delta)/delta = 3 0.0005/#e1_L + #round(e1_DI_I, 3) + #round(e1_Dd_d, 3) = #round(e1_fake_DE_E, 3) $

However, as the final uncertainty in $E$ is dominated by $(Delta I)/I$, all other uncertainties were removed from the equation due to being less than $1/3$ of the uncertainty in $I$.

$ (Delta E)/E = (Delta I)/I = #round(e1_DE_E, 3) $

This gives a final uncertainty in $E$ equal to $plus.minus#round(e1_DE_E * 100, 3)$%, $plus.minus#round(e1_DE_E * e1_E, 3)$Nm#super[-2], or $plus.minus#round(e1_DE_E * e1_E / 1e9, 3)$GPa.

== Conclusion

The value for Young's Modulus of the steel bar was found to be $E = #round(e1_E / 1e9, 3)$ $plus.minus#round(e1_DE_E * e1_E / 1e9, 3)$GPa, relatively near to the value of approximately 200GPa for most steels used in construction @etoolbox @civilsguide. This shows that the experiment went as planned and that the experimental method used was valid and reliable, as the value found was close to the expected value.

Uncertainties in length, width, height, deflection, force/mass, and second moment of area were all accounted for in the final uncertainty.

External factors that may have had a minor effect on the material, for example temperature, could not be normalised or accounted for in this experiment. This may have affected the final results or conclusions drawn from the experiment compared to a more controlled environment.

== Evaluation

#let di_i2 = 0.000001 / e1_wm + 3 * 0.000001 / e1_hm
#let de_e2 = 3 * 0.0005 / e1_L + di_i2 + e1_Dd_d

The use of a ruler or metrestick to measure the width and height of the bar resulted in a very high uncerctainty in $I$, which was carried forward into the final Young's Modulus uncertainty. This could have been improved through the use of calipers #sym.dash a set of calipers with an uncertainty of 0.001mm, as used in experiment 3, would have drastically decreased the uncertainty: the potential new uncertainty in $I$ would have been equal to $plus.minus#round(di_i2 * e1_I, 3)$m#super[4], or relatively, $plus.minus#round(di_i2 * 100, 3)$%, and the final uncertainty in $E$ would have been equal to $plus.minus#round(de_e2 * 100, 3)$%, $plus.minus#round(de_e2 * e1_E, 3)$Nm#super[-2], or $plus.minus#round(de_e2 * e1_E / 1e9, 3)$GPa. This would have been a much more accurate result than the original uncertainty.

The large number of depth measurements and small intervals of mass used in the experiment meant that the gradient of the graph was calculated with a high degree of accuracy and control over independent variables. This was reflected in the low relative uncertainty of the gradient, which was only #round(e1_gradientUncertainty / e1_d_m * 100, 3)%. The use of multiple measurements for each mass also improved the reliability of the results, as the experiment would have been considered to be repeatable and more easily replicated.

Using a steel rule or other more precise instrument instead of a metrestick to measure bar deflection may also have been beneficial, as this could have reduced any potential calibration uncertainty. Using a longer bar or more of its length would have improved the results' precision, as the deflection of the bar would have been larger and therefore easier to measure accurately. This would have also reduced the relative uncertainty in the deflection of the bar.

If the experiment were to be repeated, it would have been beneficial to use a more precise instrument to measure the deflection of the bar, such as a digital caliper, steel rule, or a laser distance sensor. This would reduce the uncertainty in the deflection measurement and thereby improve the overall accuracy of the Young's Modulus calculation.

#pagebreak()

= Experiment 2

== Aim

Experiment 2 aimed to find the Young's Modulus of the same steel bar as in Experiment 1, though with a new method of the bar being supported on both ends with the load force applied with weights in the centre of the bar.

== Underlying Physics

For this experiment, the independent variable was the force applied to the centre of the bar $F$, and the dependent variable was the deflection of the centre of the bar ($delta$). Force applied to the end of the bar was calculated with $F=m a$, identically to in the first experiment, with $a =$ #(g)ms#super[-2]. As the experiment only applied small strains to the bar, the flexural modulus of elasticity of the steel bar was equal to the Young's Modulus, calculated with the following equation @zweben:

$ E=(L^3F)/(48I delta) $

In this equation, $L$ is once again the usable length of the bar, $delta$ is the deflection of the centre of the bar, and $F$ is the load force applied to the centre of the bar. $I$, the second moment of area of the cross-section of the steel bar, is given a much higher coefficient in this equation compared to the cantilevered experiment. It is calculated using $I = (w h^3)/12$, where $w$ is the width and $h$ is the height of the steel bar, both measured in metres. This gives $I$ the same unit of m#super[4].

#figure(
	[#image("adjwilley.png", width: 60%)],
	caption: [Diagram of a generic experiment which this experiment was based on, showing a bar supported on both ends with a force applied to the centre. $w$ and $h$ indicate the width and height of the bar respectively.],
)

== Method

The bar was suspended 0.4m above the desk with 2 clamp stands. The bar was then loaded with masses in the centre of the bar (#(e2_L/2)m along its useable length of #(e2_L)m) with a piece of cord (negligible mass in itself), and the deflection of the bar was measured with a metrestick. The deflection of the bar with 0 mass applied was observed to be #round(e2_firstmean, 4)mm.

#figure(
	[#h(0.5cm)#image("diagram2.svg", width: 70%)#h(0.5cm)],
	caption: [Diagram of the experimental setup with the bar supported and fastened down securely on both ends.],
)

== Procedure

The bar was supported and clamped down at both ends, and the usable bar length was #(e2_L)m. The other dimension of the bar were identical to those used in the first experiment. Masses used ranged from 0 to 5kg, in increments of 0.5kg. Again, 3 deflection readings were taken for each mass to improve reliability of the results.

The dimensions of the bar were re-measured with a set of calipers, with a resolution and accuracy of $plus.minus$0.1mm, to ensure higher precision in its width and height. Measurements for each were made #e2_ntimes times and the mean was taken to produce more reliable values.

#text(features: ("tnum",))[#table(
	columns: range(2).map(_ => auto),
	inset: (x: 10pt),

	table.header(
		[*Width* ($w$, mm)],
		[*Height* ($h$, mm)],
	),

	..for col in e2_wmms.zip(e2_hmms) {
		([#col.at(0)], [#col.at(1)])
	}
)]

The final measurements were $w=#e2_wmm$mm and $h=#e2_hmm$mm.

== Results

=== Raw results and averages

#text(features: ("tnum",))[#table(
	columns: range(8).map(_ => auto),
	inset: (x: 10pt),

	table.header(
		table.cell(rowspan: 2)[*Mass* ($m$, kg)],
		table.cell(rowspan: 2)[*Load force* ($F$, N)],
		table.cell(colspan: 5)[*Depth Readings* ($d$, mm)],
		table.cell(rowspan: 2)[*Deflection* ($delta$, mm)],
		[1], [2], [3], [*Mean*], [*RMU*]
	),

	..for col in e2_c.zip(e2_r1, e2_r2, e2_r3) {
		let mass = col.at(0)
		let mean = (col.at(1) + col.at(2) + col.at(3)) / 3
		let rmu = (calc.max(col.at(1), col.at(2), col.at(3)) - calc.min(col.at(1), col.at(2), col.at(3))) / 3
		(
			[*#mass*],
			[#round(mass * g, 3)],
			[#col.at(1)],
			[#col.at(2)],
			[#col.at(3)],
			[#round(mean, 4)],
			[$plus.minus$ #round(rmu, 2)],
			[#round(mean - e2_firstmean, 3)],
		)
	}
)]

Again, mean depth readings were calculated with $overline(d) = 1/3(d_1 + d_2 + d_3)$. RMUs were calculated as $1/3(max d  - min d)$.

=== Graphs

// figure 8 lol
#figure(
	image("chart2.png", width: 70%),
	caption: [Graph of deflection of bar against mass applied for experiment 2, with best fit line in red.],
)

Again, the graph was found to be linear, and the gradient for the line of best fit of the above graph was calculated using the following formula.

$ (n Sigma x y - Sigma x Sigma y)/(n Sigma x^2 - (Sigma x)^2) $

In this formula, $n$ is the number of data points (#e2_n), $x$ is the mass applied, and $y$ is the bar deflection. For the collected data:

$Sigma x = #e2_x$

$Sigma y = #calc.round(e2_y, digits: -1)$

$Sigma x y = #calc.round(e2_xy, digits: -1)$

$Sigma x^2 = #e2_x2$

$(Sigma x)^2 = #e2_x_2$

This gives gradient of $delta/m = #round(e2_d_m * 1000, 3)$mmkg#super[-1], or $#round(e2_d_m, 3)$mkg#super[-1]. The gradient was divided by acceleration due to gravity $g$ ($#g$Nkg#super[-1]) to get this value in units of distance over force, resulting in $delta/(m g) = delta/F = #round(e2_d_m/g, 3)$mN#super[-1]. Rearranging for $F/delta$ gives $#round(e2_f_d, 3)$Nm#super[-1].

=== Calculations

Solving the Young's Modulus equation for this value gives the following equation.

$ F/delta = (48E I)/L^3 $

Subsituting $w$ and $h$ into this equation gives the value for $I$:

$ I = (w h^3)/12 = (#e2_wm times #e2_hm^3)/12 $

 Solving this gives a value of $I = #round(e2_I, 3)$m#super[4]. Substituting these parameters into the Young's Modulus equation, solving for $E$, and simplifying results in the following.

$
	#round(e2_f_d, 3) = (48E times #round(e2_I, 3))/(#e2_L^3)
	#h(0.5cm) therefore #h(0.5cm)
	#round(e2_f_d, 3) times #e2_L^3 = 48E times #round(e2_I, 3)
	#h(0.5cm) therefore #h(0.5cm)
	E = (#round(e2_f_d, 3) times #e2_L^3)/(48 times #round(e2_I, 3)) = #round(e2_f_d * calc.pow(e2_L, 3), 3)/#round(48 * e2_I, 3)
$

The final calculated value is $E = #round(e2_E, 3)$Nm#super[-2], equal to approximately $#round(e2_E / 1e9, 3)$GPa.

#pagebreak()

=== Calculated Uncertainties

Measured with calipers, the width $w$ and height $h$ of the bar had an uncertainty of $plus.minus$0.1mm. The scale reading uncertainties in length for $L$ and bar deflection $delta$ were both $plus.minus$0.5mm. Again, calibration uncertainties in mass $m$ and load force $F$ were considered negligible, as well as for the measurement of lengths with metresticks ($w$, $h$, $L$, $delta$) as calibration uncertainties for the instrument could not be found. RMUs in each load mass were averaged to produce a mean RMU ($Delta m$), equal to $plus.minus#round(e2_meanrmu, 3)$mm.

Once again, since the best fit line of the graph goes through the origin, there was no systematic uncertainty in the gradient of the line. Standard uncertainty in the gradient was calculated as $(Delta m)/(Delta delta)$, equalling $plus.minus#round(e2_gradientUncertainty * 1000, 3)$mmkg#super[-1], or $plus.minus#round(e2_gradientUncertainty, 3)$mkg#super[-1]. This was converted to a relative uncertainty by dividing by the gradient, giving a relative uncertainty of $plus.minus#round(e2_gradientUncertainty / e2_d_m * 100, 3)$%.

The uncertainty for the second moment of area $I$ was calculated with the following equation.

$ (Delta I)/I = (Delta w)/w + 3(Delta h)/h = 0.0005/#e2_wm + 3 times 0.0005/#e2_hm = #round(e2_DI_I, 3) $

This provides an absolute value for $Delta I$ equal to $plus.minus#round(e2_DI_I * e2_I, 3)$m#super[4], or a relative value of $plus.minus#round(e2_DI_I * 100, 3)$%.

$(Delta delta)/(delta)$ was calculated by dividing mean RMU by the mean deflection #sym.dash $(#round(e2_meanrmu, 3))/(#round(e2_meanmean, 3)) = plus.minus#round(e2_Dd_d, 3)$, resulting in a relative uncertainty of $plus.minus#round(e2_Dd_d * 100, 3)$%. $(Delta L)/L$ was found by dividing the scale reading uncertainty in length by the length of the bar, giving a relative uncertainty of $plus.minus#round(e2_DL_L * 100, 3)$%.

Finally, the total Young's Modulus uncertainty was calculated with the following equation, again derived from the original equation's powers and coefficients.

$ (Delta E)/E = 3(Delta L)/L + (Delta I)/I + (Delta delta)/delta = 3 0.0005/#e2_L + #round(e2_DI_I, 3) + #round(e2_Dd_d, 3) = #round(e2_fake_DE_E, 3) $

Once again, any uncertainties less than $1/3$ of largest uncertainty were removed from the equation, as they were not significant enough to affect the final result. For this experiment, it only included the uncertainty in the length of the bar, as $(Delta I)/I$ and $(Delta delta)/delta$ were both within $1/3$ of each other.

$ (Delta E)/E = (Delta I)/I + (Delta delta)/delta = #round(e2_DI_I, 3) + #round(e2_Dd_d, 3) = #round(e2_DE_E, 3) $

This gives the final uncertainty in $E$ equal to $plus.minus#round(e2_DE_E * 100, 3)$%, $plus.minus#round(e2_DE_E * e2_E, 3)$Nm#super[-2], or $plus.minus#round(e2_DE_E * e2_E / 1e9, 3)$GPa.

== Conclusion

In this experiment, the Young's Modulus of the steel bar was calculated to be $E = #round(e2_E / 1e9, 3)$GPa, quite close to the commonly used value of #(sym.tilde)200GPa for steel @etoolbox @civilsguide. As the value found was close to the expected value, showing that the experiment went to plan and the method used was valid and reliable. 

Uncertainties in length, width, height, deflection, force/mass, and second moment of area were once again all accounted for in the final uncertainty.

Again, external factors that may have affected the material somewhat unfortunately could not be normalised or accounted for in this experiment. This may have had impacted the final results or conclusions drawn from the experiment compared to another more controlled environment.

#pagebreak()

== Evaluation

The use of a bar supported on both ends rather than a cantilever meant that the same force applied to the bar would present a much lower deflection. This meant the measurement of small changes in deflection would be more difficult to measure accurately than in experiment 1.

However, measuring dimensions with calipers as opposed to a ruler or metrestick meant that the uncertainty in the second moment of area $I$ was much lower than in experiment 1. This resulted in a much more precise final Young's Modulus value than experiment 1.

This experiment also used fewer data points than experiment 1, meaning the gradient of the graph was calculated less reliably. This also resulted in a much higher uncertainty in deflection than experiment 1, being a significant portion of the final uncertainty in  the Young's Modulus.

A limitation of the experimental setup was that the clamp stands holding up the bar could only support a limited mass. Another method, such as supporting the bar between 2 worktops, would have allowed for a much larger mass to be applied to the bar and improved the reliability of the results by allowing for more measurements to be taken, as well as increased the deflection of the bar, making it easier to measure accurately.

Slightly more of the steel bar's length was used in this experiment, however this did not greatly improve the precision of the results, as the support of the bar from both extremities meant that the deflection of the bar was much lower than in experiment 1. A much longer bar would have been needed to produce a deflection of a similar magnitude to experiment 1, which would have improved the precision of the results and given more control over independent variables. This would have also reduced the relative uncertainty in the deflection of the bar, which was a significant portion of the final uncertainty in the Young's Modulus.

If a repeat of this experiment were to have been conducted, a longer bar or more of its length would have been used to allow the deflection to be measured more accurately. An improved support system could also have been used to let more weight be placed in the centre of the bar, which may have allowed more data points to be collected. A more precise instrument to measure the deflection of the bar, such as a steel rule, laser distance sensor, or digital caliper could also have been used to reduce the uncertainty in the deflection measurement and improve the overall accuracy of the Young's Modulus calculation.

#pagebreak()

= Experiment 3

== Aim

Experiment 3's aim was to find the Shear Modulus, also known as the modulus of rigidity, of a metal rod with rotational torsion applied to it, with one end of the rod remaining stationary while the other end was rotated.

== Underlying Physics

This experiment used torsion rather than axial or perpendicular strain, so the quantity of interest was the Shear Modulus $G$, as opposed to Young's Modulus $E$. Torsion is defined as the twisting of an object due to an applied torque.

#figure(
	[#image("orion8.png", width: 50%)],
	caption: [Diagram of a square cross-section rod with torque applied, showing deformation and warping @orion8.],
)

The independent variable was the torque applied to the end of the rod $tau$ (measured in Nm), and the dependent variable was the angle of the rod twisted from the equilibrium $theta$ (measured in #sym.degree). The Shear Modulus was calculated with the following equation for a solid, cylindrical rod @soumik:

$ G = (tau L) / (J theta) $

In this equation, $L$ represents the length of the rod, $theta$ is the angle of twist, and $tau$ is applied torque. The second polar moment of area $J$ is a measure of the rod's resistance to torsion. As the rods are cylindrical, warping does not occur.

Calculations for the second polar moment of area, a figure used in a way equivalent to the second moment of area $I$ in experiments 1 and 2, were made using the equation $J = (pi d^4)/32$. This gives $J$ a unit of m#super[4].

== Method

A set of metal rod samples used in the experiment had their diameters measured in millimetres multiple times, and averaged to produce a more reliable figure.

#text(features: ("tnum",))[#table(
	inset: (x: 10pt),

	table.header(
		[*Diameter* ($d$, mm)],
	),

	..for col in e3_samples {
		([#col],)
	}
)]

The mean diameter of the samples was calculated to be $d = #round(e3_d, 3)$mm. The length of each rod sample was $L = #(e3_L * 1000)$mm, or $#e3_L$m.

The rod samples were applied with a rotational force by a HSM31 torsion tester, allowing up to 30Nm of torque to be applied to each of the rod samples.

#figure(
	[#image("p-a-hilton.jpg", width: 70%)#h(0.5cm)],
	caption: [Photograph of a HSM31 torsion testing machine for engineering study, identical to the apparatus used in this experiment @p-a-hilton.],
)

Each sample was held at one end by a fixed chuck, and the held at the other by a chuck rotated by manually spinning the 4 large handles on the machine at a constant rate. Mostly steel rod samples were used, with some brass samples used as well. Only the results for the steel samples were used to calculate the Shear Modulus in this experiment.

#figure(
	[#image("specimens.jpg", width: 50%)#h(0.5cm)],
	caption: [Photograph of some metal rod specimens, identical to those used in this experiment. Note the hexagonal ends for allowing application of significant torque with the associated tester. @p-a-hilton2.],
)

#pagebreak()

== Procedure

Each metal rod sample was placed in the torsion tester, and the large handles were rotated at a constant speed. The angle of twist and torque were recorded with both observation of dials and a digital readout. The figures from the digital readout were considered to be more accurate than the dials, so were used for all calculations.

#figure(
	[#image("software.png", width: 70%)#h(0.5cm)],
	caption: [Screenshot of the software interface used to record the data from the torsion tester, showing how data for torque and angle of twist was gathered.],
)

The rotation continued for each sample until it fractured (shown by the sudden drop in tension for each graph), at which point the sample was removed and the machine was zeroed and reset to its equilibrium for the next sample to be placed into the testing apparatus.

== Results

=== Raw results and averages

The raw data gathered from 5 rod samples are listed below. $theta$ represents rotation in degrees (#sym.degree), and $tau$ represents torque in Newton metres (Nm). The data collected from the machine was in increments of 0.2#sym.degree, so in total was much too large to put into this report. Thus, duplicate data points and data points that did not show a change in torque for a given angle have been elided.

#text(features: ("tnum",))[#let i = 0; #table(
	columns: range(10).map(_ => auto),
	inset: (x: 10pt),

	table.header(
		..for value in (1, 2, 3, 4, 5) {
			(table.cell(colspan: 2)[*Sample #value*],)
		},
		..for value in (1, 2, 3, 4, 5) {
			(
				[$theta$ (#sym.degree)],
				[$tau$ (Nm)],
			)
		}
	),

	..while i < e3_longest {
		for (c1, c2) in e3_angles.zip(e3_torques) {
			(
				[#c1.at(i, default: "")],
				[#c2.at(i, default: "")],
			)
		}
		i += 1
	}
)]

=== Graphs

The full experimental data was used to construct these graphs.

#for g in (1, 2, 3, 4, 5) {
	figure(
		image("chart3 " + str(g) + ".png", width: 85%),
		caption: [Graph of applied torque against rotation angle for steel sample #g.],
	)
}

Calculations based directly on the gradient of these graphs were not used in this experiment, as they did not show a clear linear correlation.

=== Calculations

Calculations for the second polar moment of area $J$ were made by substituting $d$ into the following equation.

$ J = (pi d^4)/32 = (pi times #round(e3_d / 1000, 3)^4)/32 $

This results in a value of $J = #round(e3_J, 4)$m#super[4].

#let eg_theta = e3_firstangles.at(0).at(0)
#let eg_tau = e3_firsttorques.at(0).at(0)
#let eg_G =  e3_Gs.at(0).at(0)

As an example, some data from sample 1 was used to calculate the Shear Modulus $G$. The values for torque and angle of twist were taken from the first data point, found to be $theta = #eg_theta$#sym.degree ($#round(rad(eg_tau), 3)$ rad) and $tau = #eg_tau$Nm.

To calculate $G$, the Shear Modulus, the values were substituted into the following equation.

$ G = (tau L) / (J theta) = (#eg_tau times #e3_L) / (#round(e3_J, 4) times #round(rad(eg_theta), 3)) $

This gives a value of $#round(eg_G / 1e9, 3)$GPa ($#round(eg_G, 3)$Nm#super[-2]).

The above process was repeated for the first 10 data points in the sample, as these were the only points which were found to be within the range of the modulus of elasticity for the steel rod sample. This results in these values for the Shear moduli $G$:

#text(features: ("tnum",))[#table(
	columns: range(3).map(_ => auto),
	inset: (x: 10pt),

	table.header(
		[*Rotation angle* ($theta$, #sym.degree)],
		[*Applied torque* ($tau$, Nm)],
		[*Shear Modulus* ($G$, GPa)],
	),

	..for col in e3_Gs.at(0).zip(e3_firstangles.at(0), e3_firsttorques.at(0)) {
		([#col.at(1)],)
		([#col.at(2)],)
		([#round(col.at(0) / 1e9, 3)],)
	}
)]

#let eg_meanG = e3_meanGs.at(0)

Here, the mean value for $G$ was calculated to be $#round(eg_meanG / 1e9, 3)$GPa, or $#round(eg_meanG, 3)$Nm#super[-2]. Applying the same formula to all samples results in mean values calculated for each sample:

#text(features: ("tnum",))[#let n = 1; #table(
	columns: range(2).map(_ => auto),
	inset: (x: 10pt),

	table.header(
		[*Sample*],
		[*Shear Modulus* ($G$, GPa)],
	),

	..for v in e3_meanGs {
		(
			[*#n*],
			[#round(v / 1e9, 3)],
		)
		n += 1
	}
)]

Calculating the mean of these values gives a final Shear Modulus of $G = #round(e3_G / 1e9, 3)$GPa ($#round(e3_G, 3)$Nm#super[-2]).

=== Calculated Uncertainties

Rod diameters were meaured with a more accurate set of calipers, and uncertainties ($Delta d$) were $plus.minus$0.001mm. Uncertainties in rod length $Delta L$ were $plus.minus$0.5mm due to measurement with a ruler.

As measurements from the digital readout were in increments of 0.2#sym.degree and 1Nm, the uncertainties were $plus.minus$0.2#sym.degree for angle of twist, and $plus.minus$1Nm for torque.

The RMU from the example calculation can be found by taking the maximum and minimum values of $G$ and dividing by the number of values (#len):

$ 1/(#len) (#round(calc.max(..e3_Gs.at(0)) / 1e9, 3) - #round(calc.min(..e3_Gs.at(0)) / 1e9, 3)) $

This gives a RMU value of $plus.minus#round(e3_RMUs.at(0) / 1e9, 3)$GPa ($plus.minus#round(e3_RMUs.at(0), 3)$Nm#super[-2]). This can be repeated for the other samples to find the RMU for each:

#text(features: ("tnum",))[#table(
	columns: (auto,),
	inset: (x: 10pt),

	table.header(
		[*RMU* ($Delta G$, GPa)],
	),

	..for v in e3_RMUs {
		([$plus.minus$ #round(v / 1e9, 3)],)
	}
)]

Finding the mean RMU gives a value of $plus.minus#round(e3_meanRMU / 1e9, 3)$GPa ($plus.minus#round(e3_meanRMU, 3)$Nm#super[-2]).

$(Delta d)/d$ was calculated by dividing the scale reading uncertainty in diameter by the mean diameter of the rod sample, giving a relative uncertainty of $plus.minus#round(e3_Dd_d * 100, 3)$%.

The uncertainty for the second polar moment of area $J$ was calculated with the following equation.

$ (Delta J)/J = 4 (Delta d)/d = #round(e3_DJ_J, 3) $

This gives an absolute value for $Delta J = plus.minus#round(e3_DJ_J * e3_J, 3)$m#super[4], or a relative value of $plus.minus#round(e3_DJ_J * 100, 3)$%.

The overall mean value for torque $tau$ was found to be $#round(e3_tau, 3)$Nm. The uncertainty in torque was calculated by dividing the scale reading uncertainty in torque by the mean torque, giving a relative uncertainty of $plus.minus#round(e3_Dtau_tau * 100, 3)$%. The overall mean value for angle of twist was found as $theta = #round(e3_theta, 3)$#sym.degree. The uncertainty in angle of twist was calculated by dividing the scale reading uncertainty in angle of twist by the mean angle of twist, giving a relative uncertainty of $plus.minus#round(e3_Dtheta_theta * 100, 3)$%.

$(Delta L)/L$ was computed by dividing the scale reading uncertainty in  length by the rod length, giving a relative uncertainty of $plus.minus#round(e2_DL_L * 100, 3)$%.

This can be combined into an uncertainty for $G$ with this equation:

$ (Delta G)/G = (Delta tau)/tau + (Delta L)/L + (Delta J)/J + (Delta theta)/theta = #round(e3_Dtau_tau, 3) + #round(e2_DL_L, 3) + #round(e3_DJ_J, 3) + #round(e3_Dtheta_theta, 3) = #round(e3_fake_DG_G, 3) $

Again, any uncertainties less than $1/3$ of largest uncertainty were not used in the final calculation, as they were not significant enough to affect the final result. For this experiment, it only included the uncertainty in the torque, as $(Delta L)/L$, $(Delta J)/J$, and $(Delta theta)/theta$ were all much smaller than $(Delta tau)/tau$.

$ (Delta G)/G = (Delta tau)/tau = #round(e3_Dtau_tau, 3) $

Thus the final uncertainty in $G$ was equal to $plus.minus#round(e3_DG_G * 100, 3)$%, $plus.minus#round(e3_DG_G * e3_G, 3)$Nm#super[-2], or $plus.minus#round(e3_DG_G * e3_G / 1e9, 3)$GPa.

== Conclusion

The final calculated mean value of the Shear Modulus for all steel rods was $G = #round(e3_G / 1e9, 3)$ $plus.minus#round(e3_DG_G * e3_G / 1e9, 3)$GPa. This was calculated from the mean of the Shear moduli of each sample, which were all found to be within the range of the modulus of elasticity for steel.

Comparing this to the expected value of approximately 76GPa for most steels @eedge, the values found from the experiment were significantly lower than expected. This shows that the method used may not have been valid, or less likely, that the steel used in the experiment was not of a standard type or of the same yield.

Uncertainties in rod length, diameter, rotation angle, torque, and second polar moment of area were once again all accounted for in the final uncertainty.

An observation made was that each metal rod sample would fracture at the same place, near the end where the torque was applied. This may have been due to the stress unevenly distributed throughout the rod, causing a concentration of high stress at a single point or small area.

Although this experiment used machinery to assist gathering of results, analysis was found to be significantly more difficult than in experiments 1 and 2. This may have been due to the use of more complex physics concepts, or the fact that the data was not as easily visualised as in the previous experiments. The data was also much harder to interpret, as the graphs for full data were not linear and the data points were not as clearly correlated, potentially leaving room for mistakes not caught in this report. However, this is a subjective judgement and may not be true for other researchers replicating the experiment.

#pagebreak()

== Evaluation

One likely reason for the discrepancy between the expected and calculated values for the Shear Modulus is that an uncaught systematic uncertainty may have been introduced into the experiment, possibly due to miscalibration of the HSM31 torsion tester before the experiment began or in between samples. This may have caused the actual torque applied or rotation to be different from the measured values, resulting in a lower value for the Shear Modulus than expected.

The rod samples provided from the same manufacturer of the machine were considered to have been manufactured with a high degree of standardisation and quality control, as the mean diameter of the samples was very close to the manufacturer's stated diameter of 6mm.

However, some of the samples samples may have had different Young's moduli, as the accessible supply of samples was depleted during the experiment and more had to be machined, which may have resulted in a different material or manufacturing process being used as the new samples were less compatible with the torsion tesing machine than the original samples.

The samples were twisted to the point of fracture, which may not have been necessary for calculation of a reliable Shear Modulus, as it only depends on shear strain during the elastic deformation stage. As such, a more refined procedure may have resulted in the rod samples being able to be reused as long as they were not irreversibly deformed or necked during the experiment, allowing for more results to be obtained. This would have also avoided collection of data points that were not necessary for the calculation of the Shear Modulus, as well as preventing the need for machining of extra samples.

If this experiment were to have been performed again, a system to improve accuracy of torque measurement (to increments smaller than 1Nm) could have been used, as well as repeating the torsion multiple times on each steel rod without fracturing it. This would have allowed for more data points to have been collected, and a more accurate Shear Modulus to have been calculated. More precautions would have also been taken to reduce or eliminate any systematic uncertainties, such as ensuring that the machine was properly calibrated prior to each sample being tested.

#pagebreak()

= Bibliography

Vancouver-style referencing was used in this bibliography.

#bibliography("citations.yml", title: none, style: "vancouver")
